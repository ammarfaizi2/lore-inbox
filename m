Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272922AbTHPN2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272924AbTHPN2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:28:11 -0400
Received: from mx02.qsc.de ([213.148.130.14]:59025 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S272922AbTHPN2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:28:06 -0400
Date: Sat, 16 Aug 2003 15:29:03 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O16.2int
Message-ID: <20030816132902.GA709@gmx.de>
References: <200308161902.52337.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <200308161902.52337.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test3-O16.2 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Con,

On Sat, Aug 16, 2003 at 07:02:52PM +1000, Con Kolivas wrote:
> Much simpler
>=20
> Con
[ snip ]

I just had a failure on of my raid1 devices (not related I think), the
system goes on in degregated mode. At the moment I'm generating a nice
IO load with badblocks on the failed drive and a backup from the
degregated raid1 to another raid1 (on a seperate bus). During this I'm
playing xmms without much hassle and the system still feels
interactively. However, I have xterm on alt-f1 and if I press it now it
takes about 7 secs to open up. Could be better, but under this
conditions I consider this fair.

Here's a bit of vmstat:

kakerlak:/home/wiktor# vmstat 1 10
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu-=
---
r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id =
wa
1  2      0   4752  18376 148028    0    0   895  2655 1162  1952 10 4 79  7
1  2      0   4096  18604 148472    0    0  1988 29344 2360  7481 38 25  0 =
38
0  2      0   4176  18700 148284    0    0  3296 27363 2317  7298 36 27  0 =
37
0  2      0   5456  18804 146824    0    0  2392 30567 2161  7177 31 26  0 =
44
0  3      0   5392  18664 146340    0    0  3544 46644 2172  6894 29 28  0 =
42
2  3      0   5520  17888 147656    0    0  5568 21068 2173  5776 38 27  0 =
34
0  2      0   3856  17436 149700    0    0  6656 26464 2122 6654 35 29  0 36
0  2      0   4784  17392 148748    0    0  2324 30532 2175 7277 33 25  0 43
0  2      0   4016  17052 149644    0    0  2620 30412 2175 7214 37 22  0 40
0  3      0   5584  16568 148052    0    0  2632 42131 2163 7040 34 25  0 42
kakerlak:/home/wiktor#=20

--=20
Regards,

Wiktor Wodecki

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/PjGe6SNaNRgsl4MRAhuQAJ44wlYxDP7wsl6+4FHG0qMAj67/MQCdEK/i
G4qwfJA7x1j+LniFD6TZy7g=
=h1Cl
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
