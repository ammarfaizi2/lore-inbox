Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbSLEMyz>; Thu, 5 Dec 2002 07:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbSLEMyz>; Thu, 5 Dec 2002 07:54:55 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:23936 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267311AbSLEMyy> convert rfc822-to-8bit; Thu, 5 Dec 2002 07:54:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.20-aa1
Date: Fri, 6 Dec 2002 00:04:45 +1100
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212060004.54018.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

contest results for 2.4.20-aa1 on uniprocessor OSDL machine and related 2.4 
results:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              67.2    97      0       0       1.01
2.4.20 [5]              67.3    97      0       0       1.01
2.4.20aa1 [1]           68.0    97      0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              65.9    99      0       0       0.99
2.4.20 [5]              65.7    99      0       0       0.98
2.4.20aa1 [1]           65.6    99      0       0       0.98

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              106.2   58      82      40      1.59
2.4.20 [5]              108.1   58      84      40      1.62
2.4.20aa1 [2]           224.6   28      342     70      3.36

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              215.9   31      2       45      3.23
2.4.20 [5]              207.2   32      2       46      3.10
2.4.20aa1 [3]           263.7   25      3       42      3.95

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              85.6    81      2       8       1.28
2.4.20 [5]              85.4    83      2       9       1.28
2.4.20aa1 [3]           86.3    82      3       10      1.29

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              104.5   65      2       7       1.57
2.4.20 [5]              107.6   64      2       8       1.61
2.4.20aa1 [1]           127.8   53      4       9       1.91

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              182.3   37      36      14      2.73
2.4.20 [5]              203.4   33      40      15      3.05
2.4.20aa1 [3]           238.3   27      46      15      3.57

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              111.9   60      21      15      1.68
2.4.20 [5]              120.3   56      24      16      1.80
2.4.20aa1 [3]           115.5   58      23      16      1.73

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              95.8    76      16      4       1.43
2.4.20 [5]              88.8    82      16      4       1.33
2.4.20aa1 [2]           97.8    71      18      6       1.46

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              76.8    87      0       7       1.15
2.4.20 [5]              75.7    88      0       8       1.13
2.4.20aa1 [2]           78.4    85      0       9       1.17

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              87.3    78      43      2       1.31
2.4.20 [5]              84.8    80      44      2       1.27
2.4.20aa1 [3]           179.7   37      59      1       2.69

Detailed logs here when the web server syncs:
http://www.osdl.org/projects/ctdevel/results/UP/

Note: This benchmark is NOT designed to measure throughput which is likely to 
be higher in this kernel.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9707wF6dfvkL3i1gRAr2WAKCSEomguui0utiYik1+2GCA58OxRQCggg8h
eZytm2P9l3fKRPXiWj2AIGQ=
=1lkO
-----END PGP SIGNATURE-----
