Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSLUVIc>; Sat, 21 Dec 2002 16:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSLUVIc>; Sat, 21 Dec 2002 16:08:32 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:2432 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264915AbSLUVIb> convert rfc822-to-8bit; Sat, 21 Dec 2002 16:08:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] scheduler tunables with contest - exit_weight
Date: Sun, 22 Dec 2002 08:18:17 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212220818.22906.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

osdl hardware, contest results, 2.5.52-mm2 with scheduler tunable - exit 
weight (ew1= exit weight ==1 and so on)

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
ew0 [5]                 105.3   90      16      22      2.91
ew1 [5]                 86.4    97      12      18      2.39
ew2 [5]                 74.9    109     9       18      2.07
ew3 [5]                 84.2    100     11      19      2.33
ew4 [5]                 83.8    102     10      18      2.31
ew5 [5]                 89.9    93      12      20      2.48
ew6 [5]                 97.5    88      13      20      2.69
ew7 [5]                 89.2    95      12      20      2.46

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
ew0 [5]                 89.2    90      32      2       2.46
ew1 [5]                 90.5    88      33      2       2.50
ew2 [5]                 87.2    91      32      2       2.41
ew3 [5]                 88.7    92      32      2       2.45
ew4 [5]                 91.5    88      32      2       2.53
ew5 [5]                 87.7    89      32      2       2.42
ew6 [5]                 90.2    87      32      2       2.49
ew7 [5]                 88.6    91      32      2       2.45

It seems with these results at least, benefit is gained from it being on 
versus off. The actual value seems not important wrt contest.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+BNqcF6dfvkL3i1gRAqeeAJ9b3OLhmb0737HfbJG1N9QMOou8gQCeJ6OJ
p2IhcdJ3QeBx9k3QX5+6yzk=
=Iaf8
-----END PGP SIGNATURE-----
