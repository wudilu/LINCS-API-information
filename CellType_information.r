# load the package "RCurl" to connect the url
library(RCurl)

# load the package "rjson" because of the web format of LINCS API is "json"
library(rjson)

data<-data.frame()
url.first<-"http://api.lincscloud.org/a2/cellinfo?q={%22cell_id%22:%22"

# The counts of Cell Type of LINCS known 77 (2015.01.14)

for (i in 1:77)
{
    tmp<-paste(url.first,cell.id[i],sep='')
    url<-paste(tmp,"%22}&f={%22cell_histology%22:1,%22cell_lineage%22:1,%22cell_type%22:1}&user_key=lincsdemo",sep='')
    url.result<-getURL(url)
    json_data <- fromJSON(url.result)
    data.list<-do.call(rbind,json_data)
    data<-rbind(data,data.list)
}

data.result<-cbind(cell.id,data)
write.table(as.matrix(data),"API_cellinfov2.txt",sep=";",row.name=F)
