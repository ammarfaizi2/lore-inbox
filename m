Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJQB6M>; Wed, 16 Oct 2002 21:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSJQB6M>; Wed, 16 Oct 2002 21:58:12 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:47841 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S261627AbSJQB6J>;
	Wed, 16 Oct 2002 21:58:09 -0400
Message-ID: <1034820243.3dae1a935e40a@kolivas.net>
Date: Thu, 17 Oct 2002 12:04:03 +1000
From: Con Kolivas <conman@kolivas.net>
To: =?ISO-8859-1?B?RGlldGVyIE78dHplbA==?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.43 with contest
References: <200210162111.03912.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200210162111.03912.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dieter Nützel <Dieter.Nuetzel@hamburg.de>:

> But please keep a 2.4.19 (2.4.20.pre-latest/-AA) for comparison.
> The -AA VM is so GREAT for 2.4 that times can come porting some stuff to 
> 2.5...;-)

Fine every so often I'll throw in a complete set for interest. Here's one now
including 2.4.18 which was recently requested. These are results only from the
same version of contest (0.51):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              71.8    93      0       0       1.07
2.4.19 [3]              67.7    98      0       0       1.01
2.4.19-cc [3]           67.9    97      0       0       1.01
2.4.19-ck7 [3]          73.8    96      0       0       1.10
2.4.19-ck9 [2]          68.8    97      0       0       1.02
2.5.38 [3]              72.0    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.40 [1]              72.5    93      0       0       1.08
2.5.41 [1]              73.8    93      0       0       1.10
2.5.41-mm3 [1]          74.4    93      0       0       1.11
2.5.42 [2]              72.5    93      0       0       1.08
2.5.42-mm2 [3]          79.0    92      0       0       1.18
2.5.42-mm3 [2]          78.1    93      0       0       1.16
2.5.43 [2]              74.6    92      0       0       1.11
2.5.43-mm1 [4]          74.9    93      0       0       1.12

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.63
2.4.19 [3]              106.5   59      112     43      1.59
2.4.19-cc [3]           105.0   59      110     42      1.56
2.4.19-ck7 [3]          93.4    76      68      27      1.39
2.4.19-ck9 [2]          94.3    70      83      32      1.40
2.5.38 [3]              89.5    74      34      28      1.33
2.5.39 [2]              91.2    73      36      28      1.36
2.5.40 [2]              82.8    80      25      23      1.23
2.5.41 [1]              91.1    73      38      30      1.36
2.5.41-mm3 [1]          95.5    75      31      28      1.42
2.5.42 [1]              98.0    69      44      33      1.46
2.5.42-mm2 [2]          104.5   72      31      30      1.56
2.5.42-mm3 [2]          100.9   69      48      33      1.50
2.5.43 [2]              99.7    71      44      31      1.48
2.5.43-mm1 [4]          201.3   59      178     42      3.00

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.75
2.4.19 [2]              106.5   70      1       8       1.59
2.4.19-ck7 [3]          142.3   57      2       10      2.12
2.4.19-ck9 [2]          110.5   71      1       9       1.65
2.5.38 [1]              97.2    79      1       6       1.45
2.5.39 [1]              91.8    83      1       6       1.37
2.5.40 [1]              96.9    80      1       6       1.44
2.5.41 [1]              93.3    81      1       6       1.39
2.5.41-mm3 [1]          92.1    81      1       5       1.37
2.5.42 [1]              96.7    80      1       7       1.44
2.5.42-mm2 [2]          102.3   79      1       6       1.52
2.5.42-mm3 [2]          96.2    80      1       6       1.43
2.5.43 [1]              97.6    79      1       7       1.45
2.5.43-mm1 [3]          94.6    81      1       6       1.41

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.25
2.4.19 [1]              132.4   55      2       9       1.97
2.4.19-ck7 [3]          238.3   33      5       11      3.55
2.4.19-ck9 [2]          138.6   58      2       11      2.06
2.5.38 [1]              120.5   63      2       8       1.79
2.5.39 [1]              108.3   69      1       6       1.61
2.5.40 [1]              110.7   68      1       6       1.65
2.5.41 [2]              138.8   53      2       8       2.07
2.5.41-mm3 [1]          215.9   34      3       7       3.21
2.5.42 [1]              112.7   66      1       7       1.68
2.5.42-mm2 [2]          195.0   41      2       6       2.90
2.5.42-mm3 [2]          203.0   37      2       7       3.02
2.5.43 [1]              114.9   67      1       7       1.71
2.5.43-mm1 [3]          221.2   46      3       7       3.29

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      7.06
2.4.19 [3]              492.6   14      38      10      7.33
2.4.19-cc [3]           156.0   48      12      10      2.32
2.4.19-ck7 [2]          174.6   41      8       8       2.60
2.4.19-ck9 [2]          140.6   49      5       5       2.09
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.39 [2]              423.9   18      30      11      6.31
2.5.40 [1]              315.7   25      22      10      4.70
2.5.41 [2]              607.5   13      47      12      9.04
2.5.41-mm3 [1]          312.4   25      20      11      4.65
2.5.42 [1]              849.1   9       69      12      12.64
2.5.42-mm2 [2]          250.7   34      15      10      3.73
2.5.42-mm3 [2]          393.1   19      27      11      5.85
2.5.43 [1]              578.9   13      45      12      8.62
2.5.43-mm1 [3]          383.0   21      27      11      5.70

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.52
2.4.19 [2]              134.1   54      14      5       2.00
2.4.19-cc [2]           92.5    72      22      20      1.38
2.4.19-ck7 [2]          119.4   66      12      5       1.78
2.4.19-ck9 [2]          77.4    85      11      9       1.15
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.41 [1]              101.1   75      7       4       1.51
2.5.41-mm3 [1]          102.0   74      6       4       1.52
2.5.42 [1]              102.0   75      8       5       1.52
2.5.42-mm2 [2]          109.0   75      7       4       1.62
2.5.42-mm3 [2]          107.1   72      6       4       1.59
2.5.43 [3]              117.3   64      6       3       1.75
2.5.43-mm1 [3]          104.4   74      7       4       1.55

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.34
2.4.19 [1]              89.8    77      1       20      1.34
2.4.19-ck7 [2]          104.0   70      1       21      1.55
2.4.19-ck9 [2]          85.2    79      1       22      1.27
2.5.38 [1]              99.1    71      1       20      1.48
2.5.39 [1]              101.3   70      2       24      1.51
2.5.40 [1]              97.0    72      1       21      1.44
2.5.41 [1]              93.6    75      1       18      1.39
2.5.41-mm3 [1]          95.9    74      1       22      1.43
2.5.42 [1]              97.5    71      1       20      1.45
2.5.42-mm2 [2]          105.3   72      1       24      1.57
2.5.42-mm3 [2]          97.1    73      1       21      1.45
2.5.43 [2]              93.0    76      1       18      1.38
2.5.43-mm1 [3]          97.3    73      0       19      1.45

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.54
2.4.19 [3]              100.0   72      33      3       1.49
2.4.19-cc [3]           92.7    76      146     21      1.38
2.4.19-ck7 [2]          116.0   69      35      3       1.73
2.4.19-ck9 [2]          78.3    88      31      8       1.17
2.5.38 [3]              107.3   70      34      3       1.60
2.5.39 [2]              103.1   72      31      3       1.53
2.5.40 [2]              102.5   72      31      3       1.53
2.5.41 [1]              101.6   73      30      3       1.51
2.5.41-mm3 [2]          107.1   68      27      2       1.59
2.5.42 [1]              104.0   72      30      3       1.55
2.5.42-mm2 [2]          121.2   65      30      2       1.80
2.5.42-mm3 [2]          109.6   67      27      2       1.63
2.5.43 [1]              102.0   75      28      2       1.52
2.5.43-mm1 [3]          104.4   71      27      2       1.55

Cheers,
Con.
