Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSKXAxy>; Sat, 23 Nov 2002 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267111AbSKXAxy>; Sat, 23 Nov 2002 19:53:54 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:640 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267110AbSKXAxx> convert rfc822-to-8bit; Sat, 23 Nov 2002 19:53:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.49-mm1 with contest
Date: Sun, 24 Nov 2002 12:02:34 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211241202.45946.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest benchmarks for 2.5.49-mm1 with related results, including 
experimental conditions cacherun and dbench_load.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          73.8    93      0       0       1.02
2.5.49 [3]              74.0    93      0       0       1.02
2.5.49-mm1 [4]          74.1    93      0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          68.3    99      0       0       0.94
2.5.49 [3]              68.9    99      0       0       0.95
2.5.49-mm1 [4]          68.5    99      0       0       0.95

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          90.5    76      30      26      1.25
2.5.49 [3]              83.2    82      21      21      1.15
2.5.49-mm1 [4]          82.4    83      20      20      1.14

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          234.2   32      1       39      3.24
2.5.49 [3]              217.5   36      1       43      3.01
2.5.49-mm1 [3]          237.0   33      1       39      3.28

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          95.4    79      1       5       1.32
2.5.49 [3]              93.3    81      1       5       1.29
2.5.49-mm1 [3]          96.0    78      1       5       1.33

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          210.7   35      2       6       2.91
2.5.49 [3]              139.1   56      1       7       1.92
2.5.49-mm1 [3]          180.7   41      2       6       2.50

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          119.9   62      4       7       1.66
2.5.49 [3]              164.4   46      9       9       2.27
2.5.49-mm1 [3]          118.4   64      5       8       1.64

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          256.7   29      11      2       3.55
2.5.49 [3]              106.4   71      6       3       1.47
2.5.49-mm1 [3]          256.5   29      11      2       3.55

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          99.3    72      1       21      1.37
2.5.49 [3]              103.5   69      1       21      1.43
2.5.49-mm1 [3]          104.5   68      1       22      1.45

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.48-mm1 [5]          290.7   26      42      1       4.02
2.5.49 [3]              118.5   63      29      2       1.64
2.5.49-mm1 [3]          279.5   27      42      1       3.87

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94CUtF6dfvkL3i1gRAldLAKCGtLEWoaGbpDkh64bqvdt5R4R8JgCeOwoM
aB8GWwcyv4DHIV/wGqebPTo=
=p78i
-----END PGP SIGNATURE-----
