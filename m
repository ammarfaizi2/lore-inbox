Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJZWjG>; Sat, 26 Oct 2002 18:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJZWjG>; Sat, 26 Oct 2002 18:39:06 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:8064 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261661AbSJZWjF> convert rfc822-to-8bit; Sat, 26 Oct 2002 18:39:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.44-mm5 with contest
Date: Sun, 27 Oct 2002 09:43:07 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210270943.23074.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest results (http://contest.kolivas.net) results for the 2.5.44-mm* 
patches:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              74.6    93      0       0       1.03
2.5.44-mm1 [3]          75.0    93      0       0       1.03
2.5.44-mm2 [3]          76.4    93      0       0       1.05
2.5.44-mm4 [3]          75.0    93      0       0       1.03
2.5.44-mm5 [5]          75.4    91      0       0       1.04

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              90.9    76      32      26      1.25
2.5.44-mm1 [3]          191.5   36      168     64      2.64
2.5.44-mm2 [3]          193.5   38      161     62      2.66
2.5.44-mm4 [3]          191.1   36      166     63      2.63
2.5.44-mm5 [4]          191.4   36      166     63      2.63

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              97.7    80      1       6       1.34
2.5.44-mm1 [3]          99.2    78      1       6       1.37
2.5.44-mm2 [3]          96.9    79      1       5       1.33
2.5.44-mm4 [3]          97.1    79      1       5       1.34
2.5.44-mm5 [4]          97.7    78      1       5       1.34

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              117.0   65      1       7       1.61
2.5.44-mm1 [3]          156.2   49      2       7       2.15
2.5.44-mm2 [3]          176.1   44      2       7       2.42
2.5.44-mm4 [3]          183.3   41      2       8       2.52
2.5.44-mm5 [4]          181.1   44      2       7       2.49

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              873.8   9       69      12      12.03
2.5.44-mm1 [3]          347.3   22      35      15      4.78
2.5.44-mm2 [3]          294.2   28      19      10      4.05
2.5.44-mm4 [3]          358.7   23      25      10      4.94
2.5.44-mm5 [4]          270.7   29      18      11      3.73

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              110.8   68      6       3       1.53
2.5.44-mm1 [3]          110.5   69      7       3       1.52
2.5.44-mm2 [3]          104.5   73      7       4       1.44
2.5.44-mm4 [3]          105.6   71      6       4       1.45
2.5.44-mm5 [4]          103.3   74      6       4       1.42

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              99.1    71      1       21      1.36
2.5.44-mm1 [3]          96.5    74      1       22      1.33
2.5.44-mm2 [3]          94.5    75      1       22      1.30
2.5.44-mm4 [3]          96.4    74      1       21      1.33
2.5.44-mm5 [4]          95.0    75      1       20      1.31

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              114.3   67      30      2       1.57
2.5.44-mm1 [3]          159.7   47      38      2       2.20
2.5.44-mm2 [3]          116.6   64      29      2       1.60
2.5.44-mm4 [3]          114.9   65      28      2       1.58
2.5.44-mm5 [4]          114.1   65      30      2       1.57

Summary: mm5 appears a little faster under IO load, otherwise the same.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uxp+F6dfvkL3i1gRAs9AAJ9Msm/69wnFVv2rFIUi08jdAb8QFgCeO7hj
9La9w2ooWhA1qxoB+/OE3+c=
=fWTd
-----END PGP SIGNATURE-----

