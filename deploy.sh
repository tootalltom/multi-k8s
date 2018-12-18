docker build -t tootalltom/multi-client:latest -t tootalltom/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tootalltom/multi-server:latest -t tootalltom/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tootalltom/multi-worker:latest -t tootalltom/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tootalltom/multi-client:latest
docker push tootalltom/multi-server:latest
docker push tootalltom/multi-worker:latest

docker push tootalltom/multi-client:$SHA
docker push tootalltom/multi-server:$SHA
docker push tootalltom/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tootalltom/multi-server:$SHA
kubectl set image deployments/client-deployment client=tootalltom/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tootalltom/multi-worker:$SHA
