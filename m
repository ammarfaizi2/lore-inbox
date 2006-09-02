Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWIBA75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWIBA75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 20:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIBA75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 20:59:57 -0400
Received: from hentges.net ([81.169.178.128]:46299 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1750768AbWIBA74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 20:59:56 -0400
Subject: Re: 2.6.18-rc5-mm1
From: Matthias Hentges <oe@hentges.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YOWVM26GIPeZkmVRphrE"
Date: Sat, 02 Sep 2006 03:00:47 +0200
Message-Id: <1157158847.20509.10.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YOWVM26GIPeZkmVRphrE
Content-Type: multipart/mixed; boundary="=-etWsz5eMDh4HhG/CMmm4"


--=-etWsz5eMDh4HhG/CMmm4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

2.6.18-rc5-mm1 oopses on an Asus P5W DH Deluxe board, full dmesg
attached.
This did not happen in 2.6.18-rc4-mm3.


BUG: unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#1]
4K_STACKS SMP=20
last sysfs file:=20
Modules linked in:
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010087   (2.6.18-rc5-mm1 #1)=20
EIP is at rest_init+0x3feffd78/0x20
eax: 000000da   ebx: c04d5f78   ecx: c04d5f94   edx: c04d2f00
esi: 000000da   edi: 00000000   ebp: c04d2f00   esp: c0516ffc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=3Dc0516000 task=3Dc045c200 task.ti=3Dc04d5000)
Stack: c0105027=20
Call Trace:
 [<c0105027>] do_IRQ+0x8a/0xac
 [<c01035a6>] common_interrupt+0x1a/0x20
 [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
 [<c0101a83>] mwait_idle+0xc/0x1b
 [<c0101a26>] cpu_idle+0x5e/0x74
 [<c04db6fa>] start_kernel+0x363/0x36a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code:  Bad EIP value.
EIP: [<00000000>] rest_init+0x3feffd78/0x20 SS:ESP 0068:c0516ffc
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c010ca45>] smp_call_function+0x54/0xff
 [<c011a270>] printk+0x12/0x16
 [<c010cb03>] smp_send_stop+0x13/0x1c
 [<c0119480>] panic+0x49/0xd3
 [<c010410c>] die+0x273/0x28a
 [<c01126d4>] do_page_fault+0x40d/0x4db
 [<c01122c7>] do_page_fault+0x0/0x4db
 [<c03d1231>] error_code+0x39/0x40
 [<c013007b>] free_module+0x89/0xc3
 [<c0105027>] do_IRQ+0x8a/0xac
 [<c01035a6>] common_interrupt+0x1a/0x20
 [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
 [<c0101a83>] mwait_idle+0xc/0x1b
 [<c0101a26>] cpu_idle+0x5e/0x74
 [<c04db6fa>] start_kernel+0x363/0x36a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-etWsz5eMDh4HhG/CMmm4
Content-Disposition: attachment; filename=dmesg.txt.gz
Content-Type: application/x-gzip; name=dmesg.txt.gz
Content-Transfer-Encoding: base64

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
NInFZjMAAA==


--=-etWsz5eMDh4HhG/CMmm4--

--=-YOWVM26GIPeZkmVRphrE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+Ne/Aq2P5eLUP5IRAvKDAJ9YHjwayrZHPyRMY7EisZ515VbfPwCg8GGb
SfUMIHNwkX0a8BYVjk7BHkw=
=VL4T
-----END PGP SIGNATURE-----

--=-YOWVM26GIPeZkmVRphrE--


-- 
VGER BF report: H 8.89845e-07
