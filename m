Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTLWKNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 05:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTLWKNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 05:13:51 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:7088
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265079AbTLWKNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 05:13:48 -0500
Date: Tue, 23 Dec 2003 02:13:45 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6.0-mm1] kernel BUG in include/linux/list.h:148!
Message-ID: <20031223101345.GH7522@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Got one of these while messing with some DVDs and CDs (mounting them,
etc.) One of them was not inside the drive correctly, so i had to eject
it while mount was running. Could this have happened then? I didn't look
at dmesg immediately after when that may have occurred.

kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#2]
PREEMPT=20
CPU:    0
EIP:    0060:[<c016ae51>]    Not tainted VLI
EFLAGS: 00010202
EIP is at prune_dcache+0x1dc/0x1e9
eax: 00000000   ebx: cd4eab80   ecx: cd4eab94   edx: cd537e9c
esi: cd4eabf0   edi: c13b2000   ebp: 0000007e   esp: c13b3e7c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=3Dc13b2000 task=3Dc13b8d00)
Stack: cd567480 00000000 00000080 c13b2000 00000004 cffdeb20 c016b2e7 00000=
080=20
       c01436c3 00000080 000000d0 0000de8b 001a673c 00000000 0000001e 00000=
000=20
       000000f6 c035e874 00000001 ffffff85 c0144a88 000000f6 000000d0 00000=
0d0=20
Call Trace:
 [<c016b2e7>] shrink_dcache_memory+0x23/0x25
 [<c01436c3>] shrink_slab+0x110/0x153
 [<c0144a88>] balance_pgdat+0x1d6/0x1f0
 [<c0144bb4>] kswapd+0x112/0x122
 [<c011e113>] autoremove_wake_function+0x0/0x4f
 [<c03001c6>] ret_from_fork+0x6/0x14
 [<c011e113>] autoremove_wake_function+0x0/0x4f
 [<c0144aa2>] kswapd+0x0/0x122
 [<c0109255>] kernel_thread_helper+0x5/0xb

Code: 01 a8 08 75 12 8b 47 08 83 6f 14 01 a8 08 74 b0 e8 ca 1b fb ff eb a9 =
e8 c3 1b fb ff eb e7 0f 0b 95 00 9d 96 31 c0 e9 29 ff ff ff <0f> 0b 94 00 9=
d 96 31 c0 e9 10 ff ff ff 55 57 56 53 83 ec 0c 8b=20
 <6>note: kswapd0[8] exited with preempt_count 2

--=20
Joshua Kwan

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+gVWKOILr94RG8mAQIPvg/9H2hcpu2aB1KNmFcGMXYmLYHK0U5muoNu
tN95/SO4frI+RaH8BBRz8qzUgFkkvohHXr4suTl+qSr21Sho1a3n36oE7efoErfm
UD5M+aOIT8UwxoEX5u4eueFCFeJUkJ88TlSZoOOet/4gOKTa2fxvnQsK/u1l2jPE
fWN32We/Tyhi3TIvucEhBG4VUrbN510N1p7RGm4lVQmK1tfmVJVHYDPL2nf8BhZD
AjDSAMhw+NIj2JPlId905OuZEbeXi4sTv53esOgLNwXpdAbbF5SMcdSoBSnwUplM
+720hhMYDcA4xYPkEcll1dwbeSJ8spE7pKAbJ2qxPueZsTCG7o2MqCb9MsP2m75W
CPs/JLiuK38CUYqvh8HOfK8+KveDPg74dT0zuvsaCiSh3+qCZYEg1LaJuqdL2s1+
w1VUWZ/hwODjmTF6nc29ROZTb1NBlHFMp5ZfpoJ3uDMvjh7Jy1/uESM2ghCDjmZh
BMm+B1C7dXbQzPayd+hu+yXgHBbh/tJdI4BSkAWz/wD9T9EdR09m+0T4lFXK2Ujx
qU+DeOz/FU1weBvGSQa6BlIEbPqcwahqwCfNqiL81QoGwXIzbSzn7sSdoM9pI4Zu
qV+hlugMJ8tdCbOpg01Xw9qFmlwFJGTMDl5Uwj6U2U8jo/CKjXLbt+DtxExE1wHu
RYXrqasAVnY=
=UZzL
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
