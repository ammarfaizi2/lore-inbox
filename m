Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSKWWhT>; Sat, 23 Nov 2002 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSKWWhT>; Sat, 23 Nov 2002 17:37:19 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:33408 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267083AbSKWWhR> convert rfc822-to-8bit; Sat, 23 Nov 2002 17:37:17 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.49 with contest
Date: Sun, 24 Nov 2002 09:45:57 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211240946.08248.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the latest contest (http://contest.kolivas.net) benchmarks

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       0.99
2.5.47 [3]              73.5    93      0       0       1.02
2.5.48 [5]              73.9    93      0       0       1.02
2.5.48-mm1 [5]          73.8    93      0       0       1.02
2.5.49 [3]              74.0    93      0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.92
2.4.19 [2]              68.0    99      0       0       0.94
2.5.47 [3]              68.3    99      0       0       0.94
2.5.48 [5]              68.5    99      0       0       0.95
2.5.48-mm1 [5]          68.3    99      0       0       0.94
2.5.49 [3]              68.9    99      0       0       0.95

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.51
2.4.19 [3]              106.5   59      112     43      1.47
2.5.47 [3]              83.4    82      22      21      1.15
2.5.47-mm3 [2]          84.2    82      22      21      1.16
2.5.48 [5]              86.5    79      26      23      1.20
2.5.48-mm1 [5]          90.5    76      30      26      1.25
2.5.49 [3]              83.2    82      21      21      1.15

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [1]              346.6   20      1       57      4.79
2.4.19 [1]              342.6   20      1       62      4.74
2.5.47 [2]              224.2   33      1       44      3.10
2.5.48 [5]              236.4   31      1       43      3.27
2.5.48-mm1 [5]          234.2   32      1       39      3.24
2.5.49 [3]              217.5   36      1       43      3.01

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.62
2.4.19 [2]              106.5   70      1       8       1.47
2.5.47 [3]              93.9    80      1       5       1.30
2.5.48 [5]              93.5    81      1       5       1.29
2.5.48-mm1 [5]          95.4    79      1       5       1.32
2.5.49 [3]              93.3    81      1       5       1.29

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.09
2.4.19 [1]              132.4   55      2       9       1.83
2.5.47 [3]              167.1   45      2       7       2.31
2.5.48 [5]              184.4   41      2       6       2.55
2.5.48-mm1 [5]          210.7   35      2       6       2.91
2.5.49 [3]              139.1   56      1       7       1.92

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.56
2.4.19 [3]              492.6   14      38      10      6.81
2.5.47 [3]              165.9   46      9       9       2.29
2.5.48 [5]              131.4   59      6       8       1.82
2.5.48-mm1 [5]          119.9   62      4       7       1.66
2.5.49 [3]              164.4   46      9       9       2.27

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.41
2.4.19 [2]              134.1   54      14      5       1.85
2.5.47 [3]              103.4   74      6       4       1.43
2.5.48 [5]              102.9   74      6       4       1.42
2.5.48-mm1 [5]          256.7   29      11      2       3.55
2.5.49 [3]              106.4   71      6       3       1.47

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.25
2.4.19 [1]              89.8    77      1       20      1.24
2.5.47 [3]              100.2   71      1       20      1.39
2.5.48 [5]              98.2    72      1       19      1.36
2.5.48-mm1 [5]          99.3    72      1       21      1.37
2.5.49 [3]              103.5   69      1       21      1.43

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.43
2.4.19 [3]              100.0   72      33      3       1.38
2.5.47 [3]              151.1   49      35      2       2.09
2.5.48 [5]              121.2   61      30      2       1.68
2.5.48-mm1 [5]          290.7   26      42      1       4.02
2.5.49 [3]              118.5   63      29      2       1.64

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94AUmF6dfvkL3i1gRAlUKAJ42Mu81+mSDrCIGfKe9roC4WNgM/wCfdJ4X
z29k/7qd09p+P7Hr49p5vhw=
=sdZF
-----END PGP SIGNATURE-----
