Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSJ2BhJ>; Mon, 28 Oct 2002 20:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJ2BhJ>; Mon, 28 Oct 2002 20:37:09 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:22403 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S261398AbSJ2BhI>;
	Mon, 28 Oct 2002 20:37:08 -0500
Message-ID: <1035855807.3dbde7bf1bda8@kolivas.net>
Date: Tue, 29 Oct 2002 12:43:27 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.44-mm6 contest results
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contest results for 2.5.44-mm6 for comparison (Shared pagetables = y):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [6]              74.7    93      0       0       1.05
2.5.44-mm1 [3]          75.0    93      0       0       1.05
2.5.44-mm2 [3]          76.4    93      0       0       1.07
2.5.44-mm4 [3]          75.0    93      0       0       1.05
2.5.44-mm5 [7]          75.3    91      0       0       1.05
2.5.44-mm6 [3]          75.7    91      0       0       1.06

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              68.1    99      0       0       0.95
2.5.44-mm5 [2]          68.8    99      0       0       0.96
2.5.44-mm6 [3]          69.3    99      0       0       0.97

This (cacherun) is an experimental addition to contest. It is basically how fast
a second kernel compile is when conducted immediately following a previous compile.

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-mm1 [3]          191.5   36      168     64      2.68
2.5.44-mm2 [3]          193.5   38      161     62      2.71
2.5.44-mm4 [3]          191.1   36      166     63      2.68
2.5.44-mm5 [4]          191.4   36      166     63      2.68
2.5.44-mm6 [3]          190.6   36      166     63      2.67

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              97.7    80      1       6       1.37
2.5.44-mm1 [3]          99.2    78      1       6       1.39
2.5.44-mm2 [3]          96.9    79      1       5       1.36
2.5.44-mm4 [3]          97.1    79      1       5       1.36
2.5.44-mm5 [4]          97.7    78      1       5       1.37
2.5.44-mm6 [3]          97.3    79      1       5       1.36

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-mm1 [3]          156.2   49      2       7       2.19
2.5.44-mm2 [3]          176.1   44      2       7       2.47
2.5.44-mm4 [3]          183.3   41      2       8       2.57
2.5.44-mm5 [4]          181.1   44      2       7       2.54
2.5.44-mm6 [3]          207.6   37      2       7       2.91

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              873.8   9       69      12      12.24
2.5.44-mm1 [3]          347.3   22      35      15      4.86
2.5.44-mm2 [3]          294.2   28      19      10      4.12
2.5.44-mm4 [3]          358.7   23      25      10      5.02
2.5.44-mm5 [4]          270.7   29      18      11      3.79
2.5.44-mm6 [3]          284.1   28      20      10      3.98

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              110.8   68      6       3       1.55
2.5.44-mm1 [3]          110.5   69      7       3       1.55
2.5.44-mm2 [3]          104.5   73      7       4       1.46
2.5.44-mm4 [3]          105.6   71      6       4       1.48
2.5.44-mm5 [4]          103.3   74      6       4       1.45
2.5.44-mm6 [3]          104.3   73      7       4       1.46

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              99.1    71      1       21      1.39
2.5.44-mm1 [3]          96.5    74      1       22      1.35
2.5.44-mm2 [3]          94.5    75      1       22      1.32
2.5.44-mm4 [3]          96.4    74      1       21      1.35
2.5.44-mm5 [4]          95.0    75      1       20      1.33
2.5.44-mm6 [3]          95.3    75      1       20      1.33

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              114.3   67      30      2       1.60
2.5.44-mm1 [3]          159.7   47      38      2       2.24
2.5.44-mm2 [3]          116.6   64      29      2       1.63
2.5.44-mm4 [3]          114.9   65      28      2       1.61
2.5.44-mm5 [4]          114.1   65      30      2       1.60
2.5.44-mm6 [3]          226.9   33      50      2       3.18

Mem load has dropped off again

Con
