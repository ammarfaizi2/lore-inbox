Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbTBOCsg>; Fri, 14 Feb 2003 21:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268518AbTBOCsg>; Fri, 14 Feb 2003 21:48:36 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:18914 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S268515AbTBOCsf>;
	Fri, 14 Feb 2003 21:48:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.61 with contest
Date: Sat, 15 Feb 2003 13:58:26 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302151358.26741.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest (http://contest.kolivas.org) benchmarks with the osdl 
hardware (http://www.osdl.org) for 2.5.61

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   79      93.7    0.0     0.0     1.00
2.5.60              2   79      94.9    0.0     0.0     1.00
2.5.61              1   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   76      97.4    0.0     0.0     0.96
2.5.60              2   75      98.7    0.0     0.0     0.95
2.5.61              1   76      97.4    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   92      81.5    29.7    17.4    1.16
2.5.60              2   93      80.6    30.5    17.2    1.18
2.5.61              1   93      80.6    29.0    16.1    1.18
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   98      80.6    2.0     5.1     1.24
2.5.60              2   99      78.8    1.0     4.0     1.25
2.5.61              2   100     79.0    1.0     4.0     1.27
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   102     74.5    1.0     3.9     1.29
2.5.60              2   101     76.2    1.0     5.0     1.28
2.5.61              2   102     75.5    1.0     4.9     1.29
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   152     50.0    34.1    13.1    1.92
2.5.60              2   139     54.7    29.0    12.1    1.76
2.5.61              2   143     52.4    32.9    13.3    1.81
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   89      84.3    11.2    5.6     1.13
2.5.60              2   90      83.3    10.8    5.5     1.14
2.5.61              2   91      82.4    11.1    5.5     1.15
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   101     77.2    6.5     5.0     1.28
2.5.60              2   103     74.8    6.2     6.8     1.30
2.5.61              2   102     77.5    6.3     4.9     1.29
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      80.0    0.0     6.3     1.20
2.5.60              2   95      80.0    0.0     6.3     1.20
2.5.61              2   95      81.1    0.0     6.3     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      82.1    52.7    2.1     1.20
2.5.60              2   98      79.6    53.0    2.0     1.24
2.5.61              1   96      81.2    54.0    2.1     1.22
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   214     36.4    2.3     40.7    2.71
2.5.61              2   237     32.5    3.0     47.3    3.00

Dbench signalling is working it seems now

I see no significant difference b/w .60 and .61

Con
