function [Log2R,Log2Cr2,xSlope,Slope2,D,A]=CorrelationDimension_G_P_4(data,name11,filepath)

% G-P �㷨�����ά(����ʱ����������)
% ʹ��ƽ̨ - Matlab6.5 / Matlab7.0
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://luzhenbo.88uu.com.cn

X=data;

%--------------------------------------------------------------------------
% G-P�㷨�������ά

rr = 0.5;
Log2R = -6:rr:0;        % log2(r)
R = 2.^(Log2R);

t = 10;                 % ʱ��
dd = 1;                 % Ƕ��ά���
D = 2:dd:10;            % Ƕ��ά
p = 50;                 % ���ƶ��ݷ��룬��������ƽ������(�����Ǹ�����ʱ p = 1)

tic
Log2Cr = log2(CorrelationIntegral(X,t,D,R,p));       % ���ÿһ�ж�Ӧһ��Ƕ��ά
toc

%--------------------------------------------------------------------------
% �����ͼ

figure,
plot(Log2R,Log2Cr','k.-');
axis tight;
grid on;
hold on;
xlabel('log2(r)');
ylabel('log2(C(r))');
%title(['Lorenz, length = ',num2str(k2)]);

Log2Cr2=Log2Cr';

%--------------------------------------------------------------------------
% ��С�������
Linear = [3:9];                       % �����������
[A,B] = LM1(Log2R,Log2Cr,Linear);     % ��С������б�ʺͽؾ�

for i = 1:length(D),
    Y = polyval([A(i),B(i)],Log2R(Linear),1);
    plot(Log2R(Linear),Y,'r');
end
hold off;

print(gcf,'-dtiff',[filepath,'����ά_��С�������_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

%--------------------------------------------------------------------------
% ���ݶ�

Slope = diff(Log2Cr,1,2)/rr;           % ���ݶ�
xSlope = Log2R(1:end-1);               % �ݶ�����Ӧ��log2(r)

figure;
plot(xSlope,Slope','k.-');
axis tight;
grid on;
xlabel('log2(r)');
ylabel('slope');
%title(['Lorenz, length = ',num2str(k2)]);
Slope2=Slope';

print(gcf,'-dtiff',[filepath,'����ά_�ݶ�_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

%--------------------------------------------------------------------------
% ����ά����
figure;
plot(D,A,'k.-'); 
grid on; 
axis tight;
xlabel('m');
ylabel('Correlation Dimension');
%title(['Lorenz, length = ',num2str(k2)]);

print(gcf,'-dtiff',[filepath,'����ά����_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;
