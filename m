Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSKBACZ>; Fri, 1 Nov 2002 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSKBACZ>; Fri, 1 Nov 2002 19:02:25 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:17536 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265828AbSKBACV> convert rfc822-to-8bit; Fri, 1 Nov 2002 19:02:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.44 with contest
Date: Sat, 2 Nov 2002 11:07:17 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211021107.24325.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest benchmark results up to and including 2.5.44:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.4.19 [5]              69.0    97      0       0       0.97
2.5.38 [5]              72.5    93      0       0       1.02
2.5.39 [4]              72.9    93      0       0       1.02
2.5.40 [3]              73.2    93      0       0       1.03
2.5.41 [3]              73.9    92      0       0       1.04
2.5.42 [4]              73.4    93      0       0       1.03
2.5.43 [4]              74.5    92      0       0       1.04
2.5.44 [6]              74.7    93      0       0       1.05
2.5.44-mm6 [3]          75.7    91      0       0       1.06
2.5.45 [5]              74.0    93      0       0       1.04

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.4.19 [2]              68.0    99      0       0       0.95
2.5.38 [2]              67.3    99      0       0       0.94
2.5.39 [2]              67.7    99      0       0       0.95
2.5.40 [2]              67.6    99      0       0       0.95
2.5.41 [2]              67.8    99      0       0       0.95
2.5.42 [2]              68.3    99      0       0       0.96
2.5.43 [2]              68.2    99      0       0       0.96
2.5.44 [3]              68.1    99      0       0       0.95
2.5.44-mm6 [3]          69.3    99      0       0       0.97
2.5.45 [5]              67.8    99      0       0       0.95

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.4.19 [3]              106.5   59      112     43      1.49
2.5.38 [3]              89.5    74      34      28      1.25
2.5.39 [2]              91.2    73      36      28      1.28
2.5.40 [2]              82.8    80      25      23      1.16
2.5.41 [1]              91.1    73      38      30      1.28
2.5.42 [1]              98.0    69      44      33      1.37
2.5.43 [2]              99.7    71      44      31      1.40
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-mm6 [3]          190.6   36      166     63      2.67
2.5.45 [5]              91.0    75      33      27      1.27

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.4.19 [2]              106.5   70      1       8       1.49
2.5.38 [1]              97.2    79      1       6       1.36
2.5.39 [1]              91.8    83      1       6       1.29
2.5.40 [1]              96.9    80      1       6       1.36
2.5.41 [1]              93.3    81      1       6       1.31
2.5.42 [1]              96.7    80      1       7       1.35
2.5.43 [1]              97.6    79      1       7       1.37
2.5.44 [3]              97.7    80      1       6       1.37
2.5.44-mm6 [3]          97.3    79      1       5       1.36
2.5.45 [5]              97.3    79      1       7       1.36

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.4.19 [1]              132.4   55      2       9       1.85
2.5.38 [1]              120.5   63      2       8       1.69
2.5.39 [1]              108.3   69      1       6       1.52
2.5.40 [1]              110.7   68      1       6       1.55
2.5.41 [2]              138.8   53      2       8       1.94
2.5.42 [1]              112.7   66      1       7       1.58
2.5.43 [1]              114.9   67      1       7       1.61
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-mm6 [3]          207.6   37      2       7       2.91
2.5.45 [5]              112.1   68      1       7       1.57

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.4.19 [3]              492.6   14      38      10      6.90
2.5.39 [2]              423.9   18      30      11      5.94
2.5.40 [1]              315.7   25      22      10      4.42
2.5.41 [2]              607.5   13      47      12      8.51
2.5.42 [1]              849.1   9       69      12      11.89
2.5.43 [1]              578.9   13      45      12      8.11
2.5.44 [3]              873.8   9       69      12      12.24
2.5.44-mm6 [3]          284.1   28      20      10      3.98
2.5.45 [5]              621.3   12      48      12      8.70

The -mm changes could really curb this.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.4.19 [2]              134.1   54      14      5       1.88
2.5.38 [2]              100.5   76      9       5       1.41
2.5.39 [2]              101.3   74      14      6       1.42
2.5.40 [1]              101.5   73      13      5       1.42
2.5.41 [1]              101.1   75      7       4       1.42
2.5.42 [1]              102.0   75      8       5       1.43
2.5.43 [3]              117.3   64      6       3       1.64
2.5.44 [3]              110.8   68      6       3       1.55
2.5.44-mm6 [3]          104.3   73      7       4       1.46
2.5.45 [5]              102.7   75      7       4       1.44

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.4.19 [1]              89.8    77      1       20      1.26
2.5.38 [1]              99.1    71      1       20      1.39
2.5.39 [1]              101.3   70      2       24      1.42
2.5.40 [1]              97.0    72      1       21      1.36
2.5.41 [1]              93.6    75      1       18      1.31
2.5.42 [1]              97.5    71      1       20      1.37
2.5.43 [2]              93.0    76      1       18      1.30
2.5.44 [3]              99.1    71      1       21      1.39
2.5.44-mm6 [3]          95.3    75      1       20      1.33
2.5.45 [5]              94.6    75      1       18      1.32

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.4.19 [3]              100.0   72      33      3       1.40
2.5.38 [3]              107.3   70      34      3       1.50
2.5.39 [2]              103.1   72      31      3       1.44
2.5.40 [2]              102.5   72      31      3       1.44
2.5.41 [1]              101.6   73      30      3       1.42
2.5.42 [1]              104.0   72      30      3       1.46
2.5.43 [1]              102.0   75      28      2       1.43
2.5.44 [3]              114.3   67      30      2       1.60
2.5.44-mm5 [4]          114.1   65      30      2       1.60
2.5.44-mm6 [3]          226.9   33      50      2       3.18
2.5.45 [5]              104.0   72      29      2       1.46

mm5 results shown here as this change is likely to be backed out as discussed 
in previous thread.

Summary: Despite the large change from 44-45 the results are not significantly 
different.

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wxc2F6dfvkL3i1gRAuy0AJ9fVDuMJoMPnuisLiYMNGR61F95VQCcD4f2
j6d81zwE9r0MqBZ/0qLCgRc=
=rvUX
-----END PGP SIGNATURE-----

