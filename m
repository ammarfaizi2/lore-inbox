Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbTCSXGA>; Wed, 19 Mar 2003 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263258AbTCSXGA>; Wed, 19 Mar 2003 18:06:00 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24466 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S263257AbTCSXF7> convert rfc822-to-8bit;
	Wed, 19 Mar 2003 18:05:59 -0500
From: Con Kolivas <kernel@kolivas.org>
Date: Thu, 20 Mar 2003 10:16:28 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.65-mm2 with contest
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Message-Id: <200303201016.54818.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest results for mm2:

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   80      95.0    0.0     0.0     1.00
2.5.65-mm1          3   79      94.9    0.0     0.0     1.00
2.5.65-mm2          3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   76      98.7    0.0     0.0     0.95
2.5.65-mm1          3   76      98.7    0.0     0.0     0.96
2.5.65-mm2          3   76      98.7    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   243     30.5    317.0   68.3    3.04
2.5.65-mm1          3   241     30.7    309.7   67.6    3.05
2.5.65-mm2          3   240     30.8    300.7   67.5    3.04
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   108     72.2    0.0     0.0     1.35
2.5.65-mm1          3   113     69.9    1.0     6.2     1.43
2.5.65-mm2          3   108     74.1    1.0     6.5     1.37
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   106     71.7    1.0     3.8     1.32
2.5.65-mm1          3   110     70.0    1.0     4.5     1.39
2.5.65-mm2          3   104     74.0    1.0     4.8     1.32
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   411     19.0    137.5   20.4    5.14
2.5.65-mm1          3   139     56.1    49.4    20.9    1.76
2.5.65-mm2          3   136     57.4    49.7    21.3    1.72
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   164     47.6    71.7    26.2    2.05
2.5.65-mm1          3   134     58.2    60.4    27.6    1.70
2.5.65-mm2          3   138     56.5    62.3    26.6    1.75
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   107     72.9    6.3     4.7     1.34
2.5.65-mm1          3   124     62.9    9.5     6.5     1.57
2.5.65-mm2          3   127     62.2    9.8     6.3     1.61
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   98      78.6    0.0     7.1     1.23
2.5.65-mm1          3   97      79.4    0.0     7.2     1.23
2.5.65-mm2          3   98      78.6    0.0     8.2     1.24
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   112     70.5    67.3    2.7     1.40
2.5.65-mm1          3   103     76.7    53.3    1.9     1.30
2.5.65-mm2          3   103     76.7    53.7    1.9     1.30
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65              3   542     14.2    9.0     62.5    6.78
2.5.65-mm1          3   361     21.1    6.3     55.4    4.57
2.5.65-mm2          3   437     17.4    7.7     60.6    5.53

Slight changes in io based loads due to the latest anticipatory scheduler 
tweaks are evident. 

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+ePpWF6dfvkL3i1gRAmOEAJ438vVrHQolL0ZB4brHJSAGqbQ5yQCeOJ14
OPUEpbvv9oI60LrpOAwR8UA=
=YCqW
-----END PGP SIGNATURE-----

