Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSJWNiJ>; Wed, 23 Oct 2002 09:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264993AbSJWNiJ>; Wed, 23 Oct 2002 09:38:09 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:34997 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S264992AbSJWNiG>;
	Wed, 23 Oct 2002 09:38:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.44-mm3 with contest
Date: Wed, 23 Oct 2002 23:44:01 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210232344.14546.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the comparison contest benchmarks for 2.5.44-mm3

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              74.6    93      0       0       1.04
2.5.44-mm2 [3]          76.4    93      0       0       1.07
2.5.44-mm3 [1]          75.5    94      0       0       1.06

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-mm2 [3]          193.5   38      161     62      2.71
2.5.44-mm3 [1]          189.4   37      163     63      2.65

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              97.7    80      1       6       1.37
2.5.44-mm1 [3]          99.2    78      1       6       1.39
2.5.44-mm3 [1]          99.5    79      1       5       1.39

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-mm2 [3]          176.1   44      2       7       2.47
2.5.44-mm3 [2]          424.1   19      6       8       5.94

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              873.8   9       69      12      12.24
2.5.44-mm2 [3]          294.2   28      19      10      4.12
2.5.44-mm3 [2]          281.2   28      19      11      3.94

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              110.8   68      6       3       1.55
2.5.44-mm2 [3]          104.5   73      7       4       1.46
2.5.44-mm3 [1]          109.0   71      7       3       1.53

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              99.1    71      1       21      1.39
2.5.44-mm2 [3]          94.5    75      1       22      1.32
2.5.44-mm3 [1]          95.2    75      0       14      1.33

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              114.3   67      30      2       1.60
2.5.44-mm2 [3]          116.6   64      29      2       1.63
2.5.44-mm3 [2]          161.8   47      27      1       2.27

Extracting tar files and memory loading seems to have dropped off 
significantly.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9tqejF6dfvkL3i1gRAhHvAJ48zD05kaDInNHps7TfmYOPWfLsGgCeIVNH
2llcabqhvVP+WAZQEf2W7zc=
=CZ/o
-----END PGP SIGNATURE-----
