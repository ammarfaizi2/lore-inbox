Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSKRVLz>; Mon, 18 Nov 2002 16:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKRVLz>; Mon, 18 Nov 2002 16:11:55 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:1920 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264848AbSKRVLv> convert rfc822-to-8bit; Mon, 18 Nov 2002 16:11:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.48 with contest
Date: Tue, 19 Nov 2002 08:19:18 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211190819.26444.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the latest contest (http://contest.kolivas.net) benchmarks for 2.5.48 
(including experimental load additions)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.5.47 [3]              73.5    93      0       0       1.03
2.5.47-mm3 [2]          73.7    93      0       0       1.03
2.5.48 [5]              73.9    93      0       0       1.04

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.5.47 [3]              68.3    99      0       0       0.96
2.5.47-mm3 [2]          68.3    99      0       0       0.96
2.5.48 [5]              68.5    99      0       0       0.96

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.5.47 [3]              83.4    82      22      21      1.17
2.5.47-mm3 [2]          84.2    82      22      21      1.18
2.5.48 [5]              86.5    79      26      23      1.21

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [1]              346.6   20      1       57      4.85
2.5.47 [2]              224.2   33      1       44      3.14
2.5.47-mm3 [2]          201.6   38      1       39      2.82
2.5.48 [5]              236.4   31      1       43      3.31

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.5.47 [3]              93.9    80      1       5       1.32
2.5.47-mm3 [2]          94.0    81      1       6       1.32
2.5.48 [5]              93.5    81      1       5       1.31

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.5.47 [3]              167.1   45      2       7       2.34
2.5.47-mm3 [2]          211.3   38      2       6       2.96
2.5.48 [5]              184.4   41      2       6       2.58

This appears to take longer with .48 than .47


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.5.47 [3]              165.9   46      9       9       2.32
2.5.47-mm3 [2]          117.1   65      4       8       1.64
2.5.48 [5]              131.4   59      6       8       1.84

And this appears to take less time


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.5.47 [3]              103.4   74      6       4       1.45
2.5.47-mm3 [2]          218.5   34      10      2       3.06
2.5.48 [5]              102.9   74      6       4       1.44

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.5.47 [3]              100.2   71      1       20      1.40
2.5.47-mm3 [2]          101.2   71      1       21      1.42
2.5.48 [5]              98.2    72      1       19      1.38

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.5.47 [3]              151.1   49      35      2       2.12
2.5.47-mm3 [2]          243.8   31      39      1       3.41
2.5.48 [5]              121.2   61      30      2       1.70

Faster here too.


Regards,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE92VlaF6dfvkL3i1gRAtizAJ4o6BmWicNbKGKkMWp+eIh/KejPFACgqe9T
ufLDD9vad9qAENLqcmfaYD8=
=RRGa
-----END PGP SIGNATURE-----

