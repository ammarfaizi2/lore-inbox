Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272291AbTGYUR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272294AbTGYUR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:17:58 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:1807 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id S272291AbTGYURx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:17:53 -0400
Date: Fri, 25 Jul 2003 22:33:17 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.6.0-test1(-ac3) mm/slab.c - Debug
Message-ID: <20030725203317.GA14513@gentoo.lan>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux gentoo.lan 2.6.0-test1-ac3
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is a debug from my dmesg.

nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat
Apr 19 17:46:46 PDT 2003
Debug: sleeping function called from invalid context at mm/slab.c:1811
Call Trace:
 [<c011e53f>] __might_sleep+0x5f/0xa0
 [<c0140a25>] kmem_cache_alloc+0x65/0x70
 [<c014e6ad>] get_vm_area+0x2d/0x110
 [<c011c003>] __ioremap+0xb3/0x100
 [<c01b8b7e>] devfs_lookup+0x1ae/0x300
 [<c011c079>] ioremap_nocache+0x29/0xc0
 [<d4ae4fdd>] os_map_kernel_space+0x68/0x6c [nvidia]
 [<d4af6df7>] __nvsym00517+0x1f/0x2c [nvidia]
 [<d4af8cce>] __nvsym00711+0x6e/0xdc [nvidia]
 [<d4af8d5a>] __nvsym00718+0x1e/0x184 [nvidia]
 [<d4af9d88>] rm_init_adapter+0xc/0x10 [nvidia]
 [<d4ae1e60>] nv_kern_open+0x167/0x26e [nvidia]
 [<c015d0d0>] exact_match+0x0/0x10
 [<c015ce21>] chrdev_open+0xf1/0x220
 [<c01b855e>] devfs_open+0xee/0x110
 [<c01b8470>] devfs_open+0x0/0x110
 [<c0153100>] dentry_open+0x140/0x210
 [<c0152fbb>] filp_open+0x5b/0x60
 [<c0153443>] sys_open+0x53/0x90
 [<c01091ed>] sysenter_past_esp+0x52/0x71

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
                   =20

Best Regards

--=20
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZQNPRHlvMnBbacRAqe3AJ9MOEatRj9ahC9NiEODghwYkNd8DACdEe+3
GV1nxB0OyIv0iPjXmC+afOk=
=YEdP
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

