Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTAEMUg>; Sun, 5 Jan 2003 07:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTAEMUg>; Sun, 5 Jan 2003 07:20:36 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:15753 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S264681AbTAEMUd> convert rfc822-to-8bit;
	Sun, 5 Jan 2003 07:20:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.54 with contest
Date: Sun, 5 Jan 2003 23:28:51 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301052329.05842.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest (http://contest.kolivas.net) benchmarks with the osdl 
(http://www.osdl.org) hardware up to 2.5.54:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              70.0    96      0       0       1.05
2.5.50 [5]              69.9    96      0       0       1.05
2.5.51 [2]              69.8    96      0       0       1.05
2.5.52 [3]              70.2    96      0       0       1.05
2.5.53 [7]              70.1    96      0       0       1.05
2.5.54 [5]              70.0    96      0       0       1.05

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              67.4    99      0       0       1.01
2.5.50 [5]              67.3    99      0       0       1.01
2.5.51 [2]              67.2    99      0       0       1.01
2.5.52 [3]              67.5    99      0       0       1.01
2.5.53 [7]              67.6    99      0       0       1.01
2.5.54 [5]              67.6    99      0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              85.2    79      17      20      1.28
2.5.50 [5]              84.8    79      17      19      1.27
2.5.51 [2]              85.2    79      17      20      1.28
2.5.52 [3]              84.4    79      17      19      1.26
2.5.53 [7]              86.9    77      18      21      1.30
2.5.54 [5]              85.5    78      17      19      1.28

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              210.5   37      2       50      3.15
2.5.50 [5]              189.2   40      2       49      2.83
2.5.51 [12]             195.8   39      2       50      2.93
2.5.52 [3]              222.3   36      2       53      3.33
2.5.54 [5]              216.8   37      2       52      3.25

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              106.1   82      2       9       1.59
2.5.50 [5]              107.5   81      3       9       1.61
2.5.51 [7]              107.0   81      3       9       1.60
2.5.52 [3]              109.8   81      2       8       1.64
2.5.53 [7]              107.4   81      3       9       1.61
2.5.54 [4]              102.7   82      3       9       1.54

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              184.8   70      3       8       2.77
2.5.50 [5]              189.5   61      4       9       2.84
2.5.51 [7]              163.7   67      3       8       2.45
2.5.52 [3]              161.4   69      3       8       2.42
2.5.53 [7]              151.0   69      3       8       2.26
2.5.54 [4]              159.3   71      3       8       2.39

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              127.4   57      14      13      1.91
2.5.50 [5]              142.6   54      19      14      2.14
2.5.51 [7]              125.6   58      14      12      1.88
2.5.52 [7]              120.9   60      13      12      1.81
2.5.53 [7]              113.9   63      12      12      1.71
2.5.54 [4]              121.0   61      13      12      1.81

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              97.4    75      7       11      1.46
2.5.50 [5]              106.9   69      10      11      1.60
2.5.51 [7]              105.1   69      9       11      1.57
2.5.52 [7]              94.9    76      7       10      1.42
2.5.53 [7]              99.5    73      8       10      1.49
2.5.54 [4]              96.0    74      8       9       1.44

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              88.2    80      15      6       1.32
2.5.50 [5]              88.5    80      15      7       1.33
2.5.51 [2]              88.4    80      15      7       1.32
2.5.52 [3]              88.1    80      15      7       1.32
2.5.53 [7]              88.2    80      15      6       1.32
2.5.54 [4]              87.7    81      14      6       1.31

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              81.4    85      0       8       1.22
2.5.50 [5]              81.2    85      0       8       1.22
2.5.51 [2]              80.8    85      0       8       1.21
2.5.52 [3]              81.0    86      0       9       1.21
2.5.53 [7]              81.5    85      0       9       1.22
2.5.54 [4]              81.3    85      0       9       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              98.1    76      43      2       1.47
2.5.50 [5]              98.3    76      44      2       1.47
2.5.51 [7]              99.3    76      45      2       1.49
2.5.52 [3]              100.0   78      45      2       1.50
2.5.53 [7]              98.7    80      44      2       1.48
2.5.54 [4]              98.2    80      45      2       1.47

A slight speedup in ctar_load but overall no significant change.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+GCUDF6dfvkL3i1gRAoDiAKCaCaktiCQLTSiR24t0HrqkIB9+YwCdG88a
IeY5asijjP5n2f//DbYg1pI=
=fktP
-----END PGP SIGNATURE-----
