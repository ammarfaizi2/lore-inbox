Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268201AbTCFUO1>; Thu, 6 Mar 2003 15:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbTCFUO1>; Thu, 6 Mar 2003 15:14:27 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:12764 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S268201AbTCFUOZ>;
	Thu, 6 Mar 2003 15:14:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.64-mm1 with contest
Date: Fri, 7 Mar 2003 07:24:55 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303070724.55565.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

contest results:

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   79      94.9    0.0     0.0     1.00
2.5.63-mm2          3   80      92.5    0.0     0.0     1.00
2.5.64              3   79      94.9    0.0     0.0     1.00
2.5.64-mm1          5   81      91.4    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   76      97.4    0.0     0.0     0.96
2.5.63-mm2          3   75      98.7    0.0     0.0     0.94
2.5.64              3   75      98.7    0.0     0.0     0.95
2.5.64-mm1          5   75      98.7    0.0     0.0     0.93
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   92      81.5    28.2    15.2    1.16
2.5.63-mm2          3   92      80.4    29.3    16.3    1.15
2.5.64              3   92      81.5    30.0    16.3    1.16
2.5.64-mm1          5   94      78.7    30.2    18.1    1.16
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   99      79.8    1.0     4.0     1.25
2.5.63-mm2          3   112     70.5    1.0     6.2     1.40
2.5.64              3   100     79.0    0.0     0.0     1.27
2.5.64-mm1          5   114     69.3    0.8     4.4     1.41
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   102     74.5    1.0     3.9     1.29
2.5.63-mm2          3   108     70.4    1.0     4.6     1.35
2.5.64              3   103     73.8    1.0     3.9     1.30
2.5.64-mm1          5   112     67.9    1.0     4.5     1.38
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              5   217     35.0    56.7    15.1    2.75
2.5.63-mm2          3   99      75.8    15.1    7.1     1.24
2.5.64              3   229     33.2    58.8    14.8    2.90
2.5.64-mm1          5   97      77.3    13.6    6.2     1.20
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   95      78.9    15.3    8.3     1.20
2.5.63-mm2          3   92      80.4    13.2    6.5     1.15
2.5.64              3   100     75.0    18.4    9.0     1.27
2.5.64-mm1          5   93      80.6    13.7    7.5     1.15
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   106     74.5    5.7     4.7     1.34
2.5.63-mm2          3   121     64.5    8.4     5.8     1.51
2.5.64              3   103     76.7    6.2     4.9     1.30
2.5.64-mm1          5   115     68.7    8.2     6.1     1.42
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   96      79.2    0.0     6.2     1.22
2.5.63-mm2          3   99      76.8    0.0     6.1     1.24
2.5.64              3   96      79.2    0.0     6.2     1.22
2.5.64-mm1          5   100     76.0    0.0     7.0     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   104     75.0    57.7    1.9     1.32
2.5.63-mm2          3   132     59.1    90.3    2.3     1.65
2.5.64              3   105     74.3    58.3    1.9     1.33
2.5.64-mm1          5   111     70.3    63.2    1.8     1.37
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   194     39.2    2.0     38.7    2.46
2.5.63-mm2          3   236     32.2    2.7     43.2    2.95
2.5.64              3   222     34.2    2.3     38.7    2.81
2.5.64-mm1          5   231     32.9    2.6     42.0    2.85

Compared with 2.5.63-mm2 hardly any difference. Slightly better read load, 
slightly longer tar loads; the climbing mem_load problem has gone away...?

Con
