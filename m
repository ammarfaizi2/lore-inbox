Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbTC0E2W>; Wed, 26 Mar 2003 23:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbTC0E2W>; Wed, 26 Mar 2003 23:28:22 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:56472 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262859AbTC0E2T>;
	Wed, 26 Mar 2003 23:28:19 -0500
Message-ID: <1048739969.3e82808170152@kolivas.org>
Date: Thu, 27 Mar 2003 15:39:29 +1100
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.66 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest benchmarks (http://contest.kolivas.org) with the dedicated 
osdl hardware (http://www.osdl.org) up to 2.5.66 
 
no_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   79      93.7    0.0     0.0     1.00 
2.5.60              2   79      94.9    0.0     0.0     1.00 
2.5.61              1   79      94.9    0.0     0.0     1.00 
2.5.62              3   79      94.9    0.0     0.0     1.00 
2.5.63              4   79      94.9    0.0     0.0     1.00 
2.5.64              3   79      94.9    0.0     0.0     1.00 
2.5.65              3   80      95.0    0.0     0.0     1.00 
2.5.66              3   79      94.9    0.0     0.0     1.00 
cacherun: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   76      97.4    0.0     0.0     0.96 
2.5.60              2   75      98.7    0.0     0.0     0.95 
2.5.61              1   76      97.4    0.0     0.0     0.96 
2.5.62              3   76      97.4    0.0     0.0     0.96 
2.5.63              4   76      97.4    0.0     0.0     0.96 
2.5.64              3   75      98.7    0.0     0.0     0.95 
2.5.65              3   76      98.7    0.0     0.0     0.95 
2.5.66              3   76      98.7    0.0     0.0     0.96 
process_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   92      81.5    29.7    17.4    1.16 
2.5.60              2   93      80.6    30.5    17.2    1.18 
2.5.61              1   93      80.6    29.0    16.1    1.18 
2.5.62              3   92      81.5    30.0    16.3    1.16 
2.5.63              4   92      81.5    28.2    15.2    1.16 
2.5.64              3   92      81.5    30.0    16.3    1.16 
2.5.65              3   243     30.5    317.0   68.3    3.04 
2.5.66              3   241     30.7    311.0   68.0    3.05 
ctar_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   98      80.6    2.0     5.1     1.24 
2.5.60              2   99      78.8    1.0     4.0     1.25 
2.5.61              2   100     79.0    1.0     4.0     1.27 
2.5.62              3   99      79.8    1.0     4.0     1.25 
2.5.63              3   99      79.8    1.0     4.0     1.25 
2.5.64              3   100     79.0    0.0     0.0     1.27 
2.5.65              3   108     72.2    0.0     0.0     1.35 
2.5.66              3   105     74.3    0.0     0.0     1.33 
xtar_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   102     74.5    1.0     3.9     1.29 
2.5.60              2   101     76.2    1.0     5.0     1.28 
2.5.61              2   102     75.5    1.0     4.9     1.29 
2.5.62              3   103     73.8    1.0     3.9     1.30 
2.5.63              3   102     74.5    1.0     3.9     1.29 
2.5.64              3   103     73.8    1.0     3.9     1.30 
2.5.65              3   106     71.7    1.0     3.8     1.32 
2.5.66              3   105     72.4    1.0     3.8     1.33 
io_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   152     50.0    34.1    13.1    1.92 
2.5.60              2   139     54.7    29.0    12.1    1.76 
2.5.61              2   143     52.4    32.9    13.3    1.81 
2.5.62              2   205     36.6    51.7    15.0    2.59 
2.5.63              5   217     35.0    56.7    15.1    2.75 
2.5.64              3   229     33.2    58.8    14.8    2.90 
2.5.65              3   411     19.0    137.5   20.4    5.14 
2.5.66              3   438     17.8    150.4   20.9    5.54 
io_other: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   89      84.3    11.2    5.6     1.13 
2.5.60              2   90      83.3    10.8    5.5     1.14 
2.5.61              2   91      82.4    11.1    5.5     1.15 
2.5.62              2   96      78.1    15.7    8.2     1.22 
2.5.63              4   95      78.9    15.3    8.3     1.20 
2.5.64              3   100     75.0    18.4    9.0     1.27 
2.5.65              3   164     47.6    71.7    26.2    2.05 
2.5.66              3   158     49.4    70.0    27.2    2.00 
read_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   101     77.2    6.5     5.0     1.28 
2.5.60              2   103     74.8    6.2     6.8     1.30 
2.5.61              2   102     77.5    6.3     4.9     1.29 
2.5.62              2   103     75.7    6.2     4.9     1.30 
2.5.63              3   106     74.5    5.7     4.7     1.34 
2.5.64              3   103     76.7    6.2     4.9     1.30 
2.5.65              3   107     72.9    6.3     4.7     1.34 
2.5.66              3   110     70.9    6.2     4.5     1.39 
list_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   95      80.0    0.0     6.3     1.20 
2.5.60              2   95      80.0    0.0     6.3     1.20 
2.5.61              2   95      81.1    0.0     6.3     1.20 
2.5.62              2   95      80.0    0.0     6.3     1.20 
2.5.63              3   96      79.2    0.0     6.2     1.22 
2.5.64              3   96      79.2    0.0     6.2     1.22 
2.5.65              3   98      78.6    0.0     7.1     1.23 
2.5.66              3   97      79.4    0.0     7.2     1.23 
mem_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   95      82.1    52.7    2.1     1.20 
2.5.60              2   98      79.6    53.0    2.0     1.24 
2.5.61              1   96      81.2    54.0    2.1     1.22 
2.5.62              2   101     78.2    59.0    2.0     1.28 
2.5.63              3   104     75.0    57.7    1.9     1.32 
2.5.64              3   105     74.3    58.3    1.9     1.33 
2.5.65              3   112     70.5    67.3    2.7     1.40 
2.5.66              3   112     70.5    64.0    1.8     1.42 
dbench_load: 
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio 
2.5.59              3   214     36.4    2.3     40.7    2.71 
2.5.61              2   237     32.5    3.0     47.3    3.00 
2.5.62              2   226     34.1    2.5     42.0    2.86 
2.5.63              4   194     39.2    2.0     38.7    2.46 
2.5.64              3   222     34.2    2.3     38.7    2.81 
2.5.65              3   542     14.2    9.0     62.5    6.78 
2.5.66              3   459     16.6    7.0     56.6    5.81 
 
Scheduler changes put in at 2.5.65 are still evident. Only subtle differences 
since then. 
 
Con  
