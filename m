Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTBYKfr>; Tue, 25 Feb 2003 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBYKfr>; Tue, 25 Feb 2003 05:35:47 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:9662 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S267906AbTBYKfp>;
	Tue, 25 Feb 2003 05:35:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.62/3 with contest
Date: Tue, 25 Feb 2003 21:45:56 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302252145.56853.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a set of contest (http://contest.kolivas.org) benchmarks with the 
osdl hardware (http://www.osdl.org) for .62 and .63

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   79      93.7    0.0     0.0     1.00
2.5.60              2   79      94.9    0.0     0.0     1.00
2.5.61              1   79      94.9    0.0     0.0     1.00
2.5.62              3   79      94.9    0.0     0.0     1.00
2.5.63              4   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   76      97.4    0.0     0.0     0.96
2.5.60              2   75      98.7    0.0     0.0     0.95
2.5.61              1   76      97.4    0.0     0.0     0.96
2.5.62              3   76      97.4    0.0     0.0     0.96
2.5.63              4   76      97.4    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   92      81.5    29.7    17.4    1.16
2.5.60              2   93      80.6    30.5    17.2    1.18
2.5.61              1   93      80.6    29.0    16.1    1.18
2.5.62              3   92      81.5    30.0    16.3    1.16
2.5.63              4   92      81.5    28.2    15.2    1.16
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   98      80.6    2.0     5.1     1.24
2.5.60              2   99      78.8    1.0     4.0     1.25
2.5.61              2   100     79.0    1.0     4.0     1.27
2.5.62              3   99      79.8    1.0     4.0     1.25
2.5.63              3   99      79.8    1.0     4.0     1.25
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   102     74.5    1.0     3.9     1.29
2.5.60              2   101     76.2    1.0     5.0     1.28
2.5.61              2   102     75.5    1.0     4.9     1.29
2.5.62              3   103     73.8    1.0     3.9     1.30
2.5.63              3   102     74.5    1.0     3.9     1.29
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   152     50.0    34.1    13.1    1.92
2.5.60              2   139     54.7    29.0    12.1    1.76
2.5.61              2   143     52.4    32.9    13.3    1.81
2.5.62              2   205     36.6    51.7    15.0    2.59
2.5.63              5   217     35.0    56.7    15.1    2.75
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   89      84.3    11.2    5.6     1.13
2.5.60              2   90      83.3    10.8    5.5     1.14
2.5.61              2   91      82.4    11.1    5.5     1.15
2.5.62              2   96      78.1    15.7    8.2     1.22
2.5.63              4   95      78.9    15.3    8.3     1.20
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   101     77.2    6.5     5.0     1.28
2.5.60              2   103     74.8    6.2     6.8     1.30
2.5.61              2   102     77.5    6.3     4.9     1.29
2.5.62              2   103     75.7    6.2     4.9     1.30
2.5.63              3   106     74.5    5.7     4.7     1.34
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      80.0    0.0     6.3     1.20
2.5.60              2   95      80.0    0.0     6.3     1.20
2.5.61              2   95      81.1    0.0     6.3     1.20
2.5.62              2   95      80.0    0.0     6.3     1.20
2.5.63              3   96      79.2    0.0     6.2     1.22
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      82.1    52.7    2.1     1.20
2.5.60              2   98      79.6    53.0    2.0     1.24
2.5.61              1   96      81.2    54.0    2.1     1.22
2.5.62              2   101     78.2    59.0    2.0     1.28
2.5.63              3   104     75.0    57.7    1.9     1.32
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   214     36.4    2.3     40.7    2.71
2.5.61              2   237     32.5    3.0     47.3    3.00
2.5.62              2   226     34.1    2.5     42.0    2.86
2.5.63              4   194     39.2    2.0     38.7    2.46

io_load seems to have increased significantly since .62. 
mem_load has also grown but the significance of this seems low in the grand 
scheme of things.

Con
