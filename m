Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbTDBDRg>; Tue, 1 Apr 2003 22:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbTDBDRg>; Tue, 1 Apr 2003 22:17:36 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:4560 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261391AbTDBDRe> convert rfc822-to-8bit;
	Tue, 1 Apr 2003 22:17:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.66-mm2 with contest
Date: Wed, 2 Apr 2003 13:23:43 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304021324.10799.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest benchamarks for 2.5.66-mm2:

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   79      94.9    0.0     0.0     1.00
2.5.66-mm1          3   79      94.9    0.0     0.0     1.00
2.5.66-mm2          3   80      93.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   76      98.7    0.0     0.0     0.96
2.5.66-mm1          3   75      100.0   0.0     0.0     0.95
2.5.66-mm2          3   75      100.0   0.0     0.0     0.94
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   241     30.7    311.0   68.0    3.05
2.5.66-mm1          3   240     30.8    295.3   67.9    3.04
2.5.66-mm2          3   239     31.0    295.3   67.8    2.99
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   105     74.3    0.0     0.0     1.33
2.5.66-mm1          3   110     70.9    1.0     5.5     1.39
2.5.66-mm2          3   184     42.9    2.0     7.1     2.30
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   105     72.4    1.0     3.8     1.33
2.5.66-mm1          3   104     74.0    1.0     3.8     1.32
2.5.66-mm2          3   108     71.3    1.3     4.6     1.35
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   438     17.8    150.4   20.9    5.54
2.5.66-mm1          3   132     58.3    45.8    18.9    1.67
2.5.66-mm2          3   371     21.0    147.9   22.3    4.64
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   158     49.4    70.0    27.2    2.00
2.5.66-mm1          3   134     58.2    57.5    23.7    1.70
2.5.66-mm2          3   136     57.4    56.7    22.8    1.70
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   110     70.9    6.2     4.5     1.39
2.5.66-mm1          3   121     65.3    9.2     5.8     1.53
2.5.66-mm2          3   110     71.8    8.4     6.3     1.38
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   97      79.4    0.0     7.2     1.23
2.5.66-mm1          3   97      80.4    0.0     7.2     1.23
2.5.66-mm2          3   96      80.2    0.0     7.3     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   112     70.5    64.0    1.8     1.42
2.5.66-mm1          3   104     76.0    54.0    1.9     1.32
2.5.66-mm2          3   109     71.6    57.7    1.8     1.36
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   459     16.6    7.0     56.6    5.81
2.5.66-mm1          3   373     20.4    6.3     50.7    4.72
2.5.66-mm2          3   323     23.2    4.7     51.4    4.04

Big rise in ctar_load and io_load. Drop in read_load.
(All uniprocessor with IDE and AS elevator). AS tweaks? No obvious scheduler 
tweak result changes.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ilfEF6dfvkL3i1gRAhjoAJ48yMQqJ0QTJHuzbpsWsQtgUShmEwCeOz3R
IIgzmANSzpbtSagS9wnHAk8=
=BJqi
-----END PGP SIGNATURE-----

