Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJUMf4>; Mon, 21 Oct 2002 08:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJUMf4>; Mon, 21 Oct 2002 08:35:56 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3968 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261341AbSJUMfz> convert rfc822-to-8bit; Mon, 21 Oct 2002 08:35:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.44-mm2 with contest
Date: Mon, 21 Oct 2002 22:39:41 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210212239.54558.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest 0.51 results for 2.5.44-mm2

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          73.4    93      0       0       1.03
2.5.44 [3]              74.6    93      0       0       1.04
2.5.44-mm1 [3]          75.0    93      0       0       1.05
2.5.44-mm2 [3]          76.4    93      0       0       1.07

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          105.8   71      44      31      1.48
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-mm1 [3]          191.5   36      168     64      2.68
2.5.44-mm2 [3]          193.5   38      161     62      2.71

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          92.3    82      1       5       1.29
2.5.44 [3]              97.7    80      1       6       1.37
2.5.44-mm1 [3]          99.2    78      1       6       1.39
2.5.44-mm2 [3]          96.9    79      1       5       1.36

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          171.0   45      2       8       2.39
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-mm1 [3]          156.2   49      2       7       2.19
2.5.44-mm2 [3]          176.1   44      2       7       2.47

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          301.1   26      21      11      4.22
2.5.44 [3]              873.8   9       69      12      12.24
2.5.44-mm1 [3]          347.3   22      35      15      4.86
2.5.44-mm2 [3]          294.2   28      19      10      4.12

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          105.7   73      6       4       1.48
2.5.44 [3]              110.8   68      6       3       1.55
2.5.44-mm1 [3]          110.5   69      7       3       1.55
2.5.44-mm2 [3]          104.5   73      7       4       1.46

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          98.9    72      1       23      1.39
2.5.44 [3]              99.1    71      1       21      1.39
2.5.44-mm1 [3]          96.5    74      1       22      1.35
2.5.44-mm2 [3]          94.5    75      1       22      1.32

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          106.5   69      27      2       1.49
2.5.44 [3]              114.3   67      30      2       1.60
2.5.44-mm1 [3]          159.7   47      38      2       2.24
2.5.44-mm2 [3]          116.6   64      29      2       1.63

Statistical drop off on xtar load. Improvement in IO load, read load and 
substantial improvement on mem_load. Lots happening here.
 
Cheers,
Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9s/WNF6dfvkL3i1gRAn5MAKCaf5yzpsA8nin60c+aWujm9eitWgCfdwVf
oecA8CmfK8np7b40bMYqGCM=
=KIj8
-----END PGP SIGNATURE-----

