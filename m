Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbSLRVRx>; Wed, 18 Dec 2002 16:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbSLRVRx>; Wed, 18 Dec 2002 16:17:53 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:15776 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267349AbSLRVRv>;
	Wed, 18 Dec 2002 16:17:51 -0500
Message-ID: <1040246749.3e00e7ddcd8c6@kolivas.net>
Date: Thu, 19 Dec 2002 08:25:49 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.52-mm1 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are contest benchmarks for 2.5.52-mm1 for SMP only:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              39.3    180     0       0       1.09
2.5.50-mm1 [6]          39.4    181     0       0       1.09
2.5.51 [3]              39.6    180     0       0       1.09
2.5.51-mm1 [3]          39.5    181     0       0       1.09
2.5.51-mm2 [3]          39.1    182     0       0       1.08
2.5.52 [7]              39.3    181     0       0       1.09
2.5.52-mm1 [8]          39.7    180     0       0       1.10

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              36.5    194     0       0       1.01
2.5.50-mm1 [6]          36.6    194     0       0       1.01
2.5.51 [3]              36.5    195     0       0       1.01
2.5.51-mm1 [2]          36.8    194     0       0       1.02
2.5.51-mm2 [3]          36.4    195     0       0       1.01
2.5.52 [7]              36.5    194     0       0       1.01
2.5.52-mm1 [7]          36.9    194     0       0       1.02

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              47.8    148     10      46      1.32
2.5.50-mm1 [5]          47.6    150     8       43      1.31
2.5.51 [3]              50.5    139     12      54      1.39
2.5.51-mm1 [2]          51.0    138     13      56      1.41
2.5.51-mm2 [3]          48.3    145     11      49      1.33
2.5.52 [7]              48.7    144     10      49      1.34
2.5.52-mm1 [7]          49.0    144     10      50      1.35

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              54.6    157     1       10      1.51
2.5.50-mm1 [5]          51.3    155     0       4       1.42
2.5.51 [7]              58.2    158     1       10      1.61
2.5.51-mm2 [7]          55.1    158     1       11      1.52
2.5.52 [7]              56.1    161     1       10      1.55
2.5.52-mm1 [7]          55.5    156     1       10      1.53

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              116.2   103     2       10      3.21
2.5.50-mm1 [5]          83.9    111     1       9       2.32
2.5.51 [7]              104.8   124     2       10      2.89
2.5.51-mm2 [7]          100.2   112     1       10      2.77
2.5.52 [7]              83.1    138     1       9       2.29
2.5.52-mm1 [7]          77.4    122     1       8       2.14

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              87.6    102     14      22      2.42
2.5.50-mm1 [5]          99.0    92      14      21      2.73
2.5.51 [7]              84.6    102     13      21      2.34
2.5.51-mm2 [7]          86.4    101     12      21      2.39
2.5.52 [7]              73.1    111     10      19      2.02
2.5.52-mm1 [7]          80.5    108     10      19      2.22

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              59.3    139     7       18      1.64
2.5.50-mm1 [5]          70.5    125     10      22      1.95
2.5.51 [7]              64.5    134     7       18      1.78
2.5.51-mm2 [7]          64.1    133     7       20      1.77
2.5.52 [7]              75.1    120     10      21      2.07
2.5.52-mm1 [7]          60.1    131     7       18      1.66

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              49.3    151     5       7       1.36
2.5.50-mm1 [5]          52.1    142     2       3       1.44
2.5.51 [3]              48.5    154     5       7       1.34
2.5.51-mm2 [2]          49.4    151     6       7       1.36
2.5.52 [7]              49.4    151     5       7       1.36
2.5.52-mm1 [7]          49.9    149     5       6       1.38

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              43.4    167     0       8       1.20
2.5.50-mm1 [5]          44.0    167     0       7       1.22
2.5.51 [3]              43.5    167     0       8       1.20
2.5.51-mm2 [2]          43.3    168     0       8       1.20
2.5.52 [7]              43.2    167     0       9       1.19
2.5.52-mm1 [7]          43.8    167     0       9       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.50 [5]              63.3    141     36      3       1.75
2.5.50-mm1 [5]          67.1    126     39      3       1.85
2.5.51 [7]              62.6    148     38      3       1.73
2.5.51-mm2 [7]          63.0    144     38      3       1.74
2.5.52 [7]              63.5    148     38      3       1.75
2.5.52-mm1 [7]          71.1    123     36      2       1.96

Shorter times on the io writing loads (io load, io other, xtar load). 
Slightly longer time on mem_load without any increase in the amount of loads
performed.

I can't offer meaningful Uniprocessor results because unfortunately doing a make
clean, mrproper, config, dep in that testbed tree seems to invalidate previous
results even with the same .config. Why the same config can take longer or
shorter to compile after cleaning up the tree makes no sense to me but since
I've observed it I'll mention it and not post the results.

Further details and archived results can be found here:
http://www.osdl.org/projects/ctdevel/results/

Regards,
Con
