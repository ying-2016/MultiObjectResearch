function [ y,WP_POPT_ACC ] = testLogistic_nclasses(x)

% training_bugzilla_fit = csvread('training_bugzilla_fit_1.csv');
% save('training_bugzilla_fit.mat','training_bugzilla_fit','-mat');

%test_data = csvread(['..//dataset//test_',project,'.csv']);
%save(['test_',project,'_fit.mat'],'test_data','-mat');
test_data=importdata('testing_data.mat');
%test_data=importdata('training_bugzilla_fit.mat');
A = [test_data(:,1:9),test_data(:,13)];
nbug=test_data(:,10);
cost=test_data(:,12);
y=zeros(10,2);
for i = 1:1:length(x)-1
    result=A*x(i,2:11)'+x(i,1);
    pred=Logistic(result);
    WPdata(:,1) = test_data(:,10);%bug
    WPdata(:,2) = test_data(:,12);%churn
    WPdata(:,3) = pred;%ifelse(pred>0.5,1,0);%pred
    WPdata(:,4) = test_data(:,11);%density
    WP_POPT_ACC(i,1) = decPopt(WPdata);
    WP_POPT_ACC(i,2) = decACC(WPdata);
    y(i,1)=(pred>0.5)'*cost;
    y(i,2)=-(pred>0.5)'*real(nbug>0);
end

function Output = Logistic(Input)
Output = 1 ./ (1 + exp(-Input));
end
function Output = ifelse(a,b,c)
   Output = (a~=0)*b+(a==0)*c;
end
end