Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSKSVVr>; Tue, 19 Nov 2002 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbSKSVVr>; Tue, 19 Nov 2002 16:21:47 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:13531 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267162AbSKSVVp>;
	Tue, 19 Nov 2002 16:21:45 -0500
Message-ID: <1037741326.3ddaad0ef119d@kolivas.net>
Date: Wed, 20 Nov 2002 08:28:46 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.48-mm1 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest benchmarks up to 2.5.48-mm1

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       0.98
2.5.47 [3]              73.5    93      0       0       1.00
2.5.47-mm1 [5]          73.6    93      0       0       1.01
2.5.47-mm3 [2]          73.7    93      0       0       1.01
2.5.48 [5]              73.9    93      0       0       1.01
2.5.48-mm1 [5]          73.8    93      0       0       1.01

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.91
2.5.47 [3]              68.3    99      0       0       0.93
2.5.47-mm1 [5]          68.4    99      0       0       0.93
2.5.47-mm3 [2]          68.3    99      0       0       0.93
2.5.48 [5]              68.5    99      0       0       0.94
2.5.48-mm1 [5]          68.3    99      0       0       0.93

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.50
2.5.47 [3]              83.4    82      22      21      1.14
2.5.47-mm1 [5]          83.0    83      21      20      1.13
2.5.47-mm3 [2]          84.2    82      22      21      1.15
2.5.48 [5]              86.5    79      26      23      1.18
2.5.48-mm1 [5]          90.5    76      30      26      1.24

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [1]              346.6   20      1       57      4.73
2.5.47 [2]              224.2   33      1       44      3.06
2.5.47-mm3 [2]          201.6   38      1       39      2.75
2.5.48 [5]              236.4   31      1       43      3.23
2.5.48-mm1 [5]          234.2   32      1       39      3.20

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.60
2.5.47 [3]              93.9    80      1       5       1.28
2.5.47-mm1 [5]          94.0    81      1       5       1.28
2.5.47-mm3 [2]          94.0    81      1       6       1.28
2.5.48 [5]              93.5    81      1       5       1.28
2.5.48-mm1 [5]          95.4    79      1       5       1.30

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.06
2.5.47 [3]              167.1   45      2       7       2.28
2.5.47-mm1 [5]          118.5   64      1       7       1.62
2.5.47-mm3 [2]          211.3   38      2       6       2.89
2.5.48 [5]              184.4   41      2       6       2.52
2.5.48-mm1 [5]          210.7   35      2       6       2.88

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.48
2.5.47 [3]              165.9   46      9       9       2.27
2.5.47-mm1 [5]          126.3   61      5       8       1.73
2.5.47-mm3 [2]          117.1   65      4       8       1.60
2.5.48 [5]              131.4   59      6       8       1.79
2.5.48-mm1 [5]          119.9   62      4       7       1.64

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.40
2.5.47 [3]              103.4   74      6       4       1.41
2.5.47-mm1 [5]          100.6   76      7       4       1.37
2.5.47-mm3 [2]          218.5   34      10      2       2.98*
2.5.48 [5]              102.9   74      6       4       1.41
2.5.48-mm1 [5]          256.7   29      11      2       3.51*

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.23
2.5.47 [3]              100.2   71      1       20      1.37
2.5.47-mm1 [5]          102.4   69      1       19      1.40
2.5.47-mm3 [2]          101.2   71      1       21      1.38
2.5.48 [5]              98.2    72      1       19      1.34
2.5.48-mm1 [5]          99.3    72      1       21      1.36

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.41
2.5.47 [3]              151.1   49      35      2       2.06
2.5.47-mm1 [5]          127.0   58      29      2       1.73
2.5.47-mm3 [2]          243.8   31      39      1       3.33*
2.5.48 [5]              121.2   61      30      2       1.66
2.5.48-mm1 [5]          290.7   26      42      1       3.97*

Con
