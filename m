Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTH2U2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTH2U2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:28:30 -0400
Received: from gondola.steamballoon.com ([209.151.1.130]:43414 "EHLO
	gondola.steamballoon.com") by vger.kernel.org with ESMTP
	id S263525AbTH2U1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:27:09 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6Hnsd6hNa7SzogzMkv8J"
Message-Id: <1062188787.4062.21.camel@elenuial.steamballoon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 29 Aug 2003 16:26:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6Hnsd6hNa7SzogzMkv8J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ran it on a few systems here.

Corel NetWinder (275MHz StrongARM)
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: FAIL - cache not coherent
Test separation: 32768 bytes: FAIL - cache not coherent
Test separation: 65536 bytes: FAIL - cache not coherent
Test separation: 131072 bytes: FAIL - cache not coherent
Test separation: 262144 bytes: FAIL - cache not coherent
Test separation: 524288 bytes: FAIL - cache not coherent
Test separation: 1048576 bytes: FAIL - cache not coherent
Test separation: 2097152 bytes: FAIL - cache not coherent
Test separation: 4194304 bytes: FAIL - cache not coherent
Test separation: 8388608 bytes: FAIL - cache not coherent
Test separation: 16777216 bytes: FAIL - cache not coherent
VM page alias coherency test: failed; will use copy buffers instead

cat /proc/cpuinfo
Processor       : StrongARM-110 rev 3 (v4l)
BogoMIPS        : 185.95
Features        : swp half 26bit fastmult
=20
Hardware        : Rebel-NetWinder
Revision        : 52ff
Serial          : 00000000000008bf



HP zx6000 (2xItanium 2)
time ./test
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
                                                                           =
    =20
real    0m7.455s
user    0m7.412s
sys     0m0.040s

cat /proc/cpuinfo
processor  : 0
vendor     : GenuineIntel
arch       : IA-64
family     : Itanium 2
model      : 0
revision   : 7
archrev    : 0
features   : branchlong
cpu number : 0
cpu regs   : 4
cpu MHz    : 900.000000
itc MHz    : 900.000000
BogoMIPS   : 1346.37





--=-6Hnsd6hNa7SzogzMkv8J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/T7bwqJaxCwvMzfwRAmzeAJ9rcMyEm0f+ulKxCqDRJ2/i+Bz+ZgCgtJMy
+bcx6vSEXnDICrldz0ki+zE=
=o47r
-----END PGP SIGNATURE-----

--=-6Hnsd6hNa7SzogzMkv8J--

