Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270388AbTGUPwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270183AbTGUPwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:52:06 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:64438 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S270388AbTGUPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:50:52 -0400
Subject: [2.6.0-test1] Unable to handle kernel NULL pointer dereference at
	virtual address 00000324
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tMdqUHM5rlM2Y6VAE9GK"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1058803534.28902.2.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 18:05:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tMdqUHM5rlM2Y6VAE9GK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello.

With test1 and the bitkeeper changesets until yesterday, I obtain this

Unable to handle kernel NULL pointer dereference at virtual address
00000324
 printing eip:
c01605a9
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01605a9>]    Not tainted
EFLAGS: 00010206
EIP is at iput+0x9/0x80
eax: 00000000   ebx: 00000200   ecx: caab2664   edx: caab2664
esi: 00000200   edi: c13e4000   ebp: 00000061   esp: c13e5e88
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=3Dc13e4000 task=3Dc13eac60)
Stack: caab2640 c015ddf3 00000200 00000080 c13e4000 00000041 cfffeba0
c015e273=20
       00000080 c0138968 00000080 000000d0 0000d4c8 01e04b6c 00000000
00000241=20
       00000000 0000035a c027826c fffffffd 00000001 c0139abe 0000035a
000000d0=20
Call Trace:
 [<c015ddf3>] prune_dcache+0x153/0x1a0
 [<c015e273>] shrink_dcache_memory+0x33/0x40
 [<c0138968>] shrink_slab+0x108/0x160
 [<c0139abe>] balance_pgdat+0x15e/0x180
 [<c0139be6>] kswapd+0x106/0x120
 [<c01180a0>] autoremove_wake_function+0x0/0x40
 [<c0108d96>] ret_from_fork+0x6/0x20
 [<c01180a0>] autoremove_wake_function+0x0/0x40
 [<c0139ae0>] kswapd+0x0/0x120
 [<c0106fe5>] kernel_thread_helper+0x5/0x20

Code: 83 bb 24 01 00 00 20 8b 83 80 00 00 00 8b 40 24 74 4b 85 c0
--=20
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\
| Ram=F3n Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/

--=-tMdqUHM5rlM2Y6VAE9GK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HA9ORGk68b69cdURArnUAJ9vS+aGfVSLnoDmKpD5gkbLr4sYYACfWKNa
QCX3mUjDLl3TOhrzyqCc8bc=
=1Ej8
-----END PGP SIGNATURE-----

--=-tMdqUHM5rlM2Y6VAE9GK--

