Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTBKTbp>; Tue, 11 Feb 2003 14:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTBKTbp>; Tue, 11 Feb 2003 14:31:45 -0500
Received: from mail016.syd.optusnet.com.au ([210.49.20.174]:18581 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S265305AbTBKTbm>; Tue, 11 Feb 2003 14:31:42 -0500
From: Con Kolivas <ckolivas@yahoo.com.au>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.60-mm1 with contest
Date: Wed, 12 Feb 2003 06:41:27 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302120641.27220.ckolivas@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   79      93.7    0.0     0.0     1.00
2.5.59-mm10         3   79      93.7    0.0     0.0     1.00
2.5.59-mm8          3   79      93.7    0.0     0.0     1.00
2.5.60              2   79      94.9    0.0     0.0     1.00
2.5.60-mm1          3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   76      97.4    0.0     0.0     0.96
2.5.59-mm10         3   76      97.4    0.0     0.0     0.96
2.5.59-mm8          3   76      97.4    0.0     0.0     0.96
2.5.60              2   75      98.7    0.0     0.0     0.95
2.5.60-mm1          3   75      100.0   0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   92      81.5    29.7    17.4    1.16
2.5.59-mm10         3   187     39.6    194.0   58.8    2.37
2.5.59-mm8          3   193     38.9    200.3   60.1    2.44
2.5.60              2   93      80.6    30.5    17.2    1.18
2.5.60-mm1          3   91      78.0    32.3    18.7    1.15
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   98      80.6    2.0     5.1     1.24
2.5.59-mm10         3   99      78.8    1.7     4.0     1.25
2.5.59-mm8          3   98      79.6    2.0     5.1     1.24
2.5.60              2   99      78.8    1.0     4.0     1.25
2.5.60-mm1          3   98      79.6    1.0     4.1     1.24
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   102     74.5    1.0     3.9     1.29
2.5.59-mm10         3   100     76.0    1.0     4.0     1.27
2.5.59-mm8          3   101     75.2    1.0     4.0     1.28
2.5.60              2   101     76.2    1.0     5.0     1.28
2.5.60-mm1          3   108     70.4    1.0     3.7     1.37
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   152     50.0    34.1    13.1    1.92
2.5.59-mm10         3   148     51.4    35.2    14.2    1.87
2.5.59-mm8          3   155     49.0    35.6    12.9    1.96
2.5.60              2   139     54.7    29.0    12.1    1.76
2.5.60-mm1          3   112     67.0    15.7    7.1     1.42
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   89      84.3    11.2    5.6     1.13
2.5.59-mm10         3   115     66.1    35.0    18.3    1.46
2.5.59-mm8          3   115     67.0    33.4    17.4    1.46
2.5.60              2   90      83.3    10.8    5.5     1.14
2.5.60-mm1          3   89      84.3    10.5    5.6     1.13
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   101     77.2    6.5     5.0     1.28
2.5.59-mm10         3   93      81.7    2.8     2.2     1.18
2.5.59-mm8          3   93      81.7    2.8     2.2     1.18
2.5.60              2   103     74.8    6.2     6.8     1.30
2.5.60-mm1          3   93      81.7    2.8     2.2     1.18
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      80.0    0.0     6.3     1.20
2.5.59-mm10         3   97      79.4    0.0     6.2     1.23
2.5.59-mm8          3   97      79.4    0.0     6.2     1.23
2.5.60              2   95      80.0    0.0     6.3     1.20
2.5.60-mm1          3   96      79.2    0.0     6.2     1.22
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      82.1    52.7    2.1     1.20
2.5.59-mm10         3   97      79.4    53.7    2.0     1.23
2.5.59-mm8          3   100     78.0    57.7    2.0     1.27
2.5.60              2   98      79.6    53.0    2.0     1.24
2.5.60-mm1          3   95      82.1    51.7    2.1     1.20

Con
