Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKXSQQ>; Sun, 24 Nov 2002 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKXSQQ>; Sun, 24 Nov 2002 13:16:16 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:45831 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261550AbSKXSQP>; Sun, 24 Nov 2002 13:16:15 -0500
Message-ID: <20021124182321.29180.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: davidsen@tmr.com
Date: Mon, 25 Nov 2002 02:23:21 +0800
Subject: [Benchmark] resp results against 2.4.19 2.5.47 .48 .49
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Kernel version: 2.4.19
  Starting 1 CPU run with 251 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    119.689    123.927    119.767    120.583    0.002    1.000
     smallwrite    115.959    248.613    120.702    156.237    0.057    1.296
     largewrite    124.577  19147.936   5256.843   7038.559    8.112   58.371
        cpuload    115.120    240.529    115.173    140.965    0.056    1.169
      spawnload    232.222    329.639    264.046    269.592    0.040    2.236
       8ctx-mem    428.699   7751.830    873.124   2600.109    3.076   21.563
       2ctx-mem    619.219   7380.309    964.060   2571.172    2.905   21.323

		Kernel version: 2.5.47
  Starting 1 CPU run with 249 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.719    114.730    114.665    114.482    0.000    1.000
     smallwrite    115.739    160.188    119.257    126.771    0.019    1.107
     largewrite    115.881    259.473    155.366    163.716    0.058    1.430
        cpuload    103.658    146.410    103.741    112.251    0.019    0.981
      spawnload    116.321    168.477    116.652    126.952    0.023    1.109
       8ctx-mem    132.232   7654.087   1395.729   2960.144    3.079   25.857
       2ctx-mem    485.961   8839.320    906.673   2707.681    3.504   23.652

		Kernel version: 2.5.48
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.801    114.898    114.634    114.496    0.000    1.000
     smallwrite    117.256    234.563    118.198    141.648    0.052    1.237
     largewrite    110.861    156.290    116.685    127.055    0.021    1.110
        cpuload    103.763    145.123    104.641    113.080    0.018    0.988
      spawnload    116.558    167.326    116.686    126.904    0.023    1.108
       8ctx-mem   1004.047   9164.164   2793.414   3433.079    3.336   29.984
       2ctx-mem    373.429   8916.042   2478.937   3273.987    3.326   28.595

		Kernel version: 2.5.49
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload     98.683    105.725    100.804    101.628    0.003    1.000
     smallwrite    115.475    230.990    136.056    151.460    0.047    1.490
     largewrite    115.634    274.951    120.188    164.515    0.073    1.619
        cpuload     99.333    141.206     99.729    108.005    0.019    1.063
      spawnload    114.815    166.774    115.595    125.843    0.023    1.238
       8ctx-mem    276.880   8352.847    401.863   2063.760    3.527   20.307
       2ctx-mem    216.351   9420.066    343.468   2216.080    4.036   21.806


-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
