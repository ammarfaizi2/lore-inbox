Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTJLLx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJLLx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:53:28 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:15780 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263454AbTJLLxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:53:24 -0400
Subject: [2.6.0-test7-bk][OOPS] Unable to handle kernel paging request at
	virtual address f9a7e857
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ODY6EugBoM0bd7nGt2kI"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1065959373.1111.13.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 12 Oct 2003 13:49:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ODY6EugBoM0bd7nGt2kI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Unable to handle kernel paging request at virtual address f9a7e857
 printing eip:
c0169361
*pde =3D 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0169361>]    Not tainted
EFLAGS: 00010217
EIP is at mpage_readpages+0x41/0x140
eax: c01602af   ebx: f9a7e853   ecx: caab053c   edx: caab053c
esi: f9a7e84b   edi: 00000000   ebp: caab072c   esp: cfe03e04
ds: 007b   es: 007b   ss: 0068 =20
Process kswapd0 (pid: 8, threadinfo=3Dcfe02000 task=3Dcfe08ca0)
Stack: 00000000 00000000 00000000 00000000 cfe03e10 00000000 c02ef348
c011e55a
       00000000 00000001 c011e36c 00000046 cfe02000 00000000 00000000
c02cca00
       c010aaef c0273900 c80b5f40 c80b6c8c cfe02000 00000028 caab072c
caab072c
Call Trace:
 [<c011e55a>] tasklet_action+0x3a/0x60
 [<c011e36c>] do_softirq+0x8c/0xa0
 [<c010aaef>] do_IRQ+0xef/0x120
 [<c0180536>] ext3_readpages+0x16/0x20
 [<c01602af>] prune_dcache+0x14f/0x1c0
 [<c017f840>] ext3_get_block+0x0/0x80
 [<c0162b23>] iput+0x63/0x80
 [<c01602af>] prune_dcache+0x14f/0x1c0
 [<c0160753>] shrink_dcache_memory+0x33/0x40
 [<c013a508>] shrink_slab+0x108/0x160
 [<c013b783>] balance_pgdat+0x1c3/0x1e0
 [<c013b89e>] kswapd+0xfe/0x120
 [<c0118c60>] autoremove_wake_function+0x0/0x40
 [<c0108ed6>] ret_from_fork+0x6/0x20
 [<c0118c60>] autoremove_wake_function+0x0/0x40
 [<c013b7a0>] kswapd+0x0/0x120
 [<c0107061>] kernel_thread_helper+0x5/0x24

Code: 8b 43 04 8b 13 89 42 04 89 10 c7 43 04 00 02 20 00 c7 03 00

--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-ODY6EugBoM0bd7nGt2kI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/iT/NRGk68b69cdURAqD7AJ9tLS6B4M0Ea76dc7lSZEjRKhbE7ACeJ9jR
dslUnrnj7I4JicoIhmSgvYU=
=BeJ4
-----END PGP SIGNATURE-----

--=-ODY6EugBoM0bd7nGt2kI--

