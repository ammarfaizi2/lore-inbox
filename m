Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSJLGSX>; Sat, 12 Oct 2002 02:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSJLGSX>; Sat, 12 Oct 2002 02:18:23 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:2176 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262812AbSJLGSW> convert rfc822-to-8bit; Sat, 12 Oct 2002 02:18:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.42 with contest 0.51
Date: Sat, 12 Oct 2002 16:21:44 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210121621.50248.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the updated benchmarks with contest (http://contest.kolivas.net)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.5.38 [3]              72.0    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.40 [1]              72.5    93      0       0       1.08
2.5.41 [1]              73.8    93      0       0       1.10
2.5.41-mm3 [1]          74.4    93      0       0       1.11
2.5.42 [1]              72.4    93      0       0       1.08

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.59
2.5.38 [3]              89.5    74      34      28      1.33
2.5.39 [2]              91.2    73      36      28      1.36
2.5.40 [2]              82.8    80      25      23      1.23
2.5.41 [1]              91.1    73      38      30      1.36
2.5.41-mm3 [1]          95.5    75      31      28      1.42
2.5.42 [1]              98.0    69      44      33      1.46

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.59
2.5.38 [1]              97.2    79      1       6       1.45
2.5.39 [1]              91.8    83      1       6       1.37
2.5.40 [1]              96.9    80      1       6       1.44
2.5.41 [1]              93.3    81      1       6       1.39
2.5.41-mm3 [1]          92.1    81      1       5       1.37
2.5.42 [1]              96.7    80      1       7       1.44

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.97
2.5.38 [1]              120.5   63      2       8       1.79
2.5.39 [1]              108.3   69      1       6       1.61
2.5.40 [1]              110.7   68      1       6       1.65
2.5.41 [2]              138.8   53      2       8       2.07
2.5.41-mm3 [1]          215.9   34      3       7       3.21
2.5.42 [1]              112.7   66      1       7       1.68

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      7.33
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.39 [2]              423.9   18      30      11      6.31
2.5.40 [1]              315.7   25      22      10      4.70
2.5.41 [2]              607.5   13      47      12      9.04
2.5.41-mm3 [1]          312.4   25      20      11      4.65
2.5.42 [1]              849.1   9       69      12      12.64

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       2.00
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.41 [1]              101.1   75      7       4       1.51
2.5.41-mm3 [1]          102.0   74      6       4       1.52
2.5.42 [1]              102.0   75      8       5       1.52

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.34
2.5.38 [1]              99.1    71      1       20      1.48
2.5.39 [1]              101.3   70      2       24      1.51
2.5.40 [1]              97.0    72      1       21      1.44
2.5.41 [1]              93.6    75      1       18      1.39
2.5.41-mm3 [1]          95.9    74      1       22      1.43
2.5.42 [1]              97.5    71      1       20      1.45

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.49
2.5.38 [3]              107.3   70      34      3       1.60
2.5.39 [2]              103.1   72      31      3       1.53
2.5.40 [2]              102.5   72      31      3       1.53
2.5.41 [1]              101.6   73      30      3       1.51
2.5.41-mm3 [2]          107.1   68      27      2       1.59
2.5.42 [1]              104.0   72      30      3       1.55

There appears to be no significant change from .41. The longer duration under 
IO load is probably not important as I didnt run it again to get an average - 
basically both .41 and .42 can choke the system with IO writes.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9p797F6dfvkL3i1gRAiOxAKCEy6sGZlGMt+/6HXXKTTAnB8EY7ACgkBcb
0z+QXcZ1wO7zbjWs885589M=
=+bK5
-----END PGP SIGNATURE-----

