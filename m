Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285077AbRLQKNU>; Mon, 17 Dec 2001 05:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285087AbRLQKNK>; Mon, 17 Dec 2001 05:13:10 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:56069 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S285077AbRLQKNA>; Mon, 17 Dec 2001 05:13:00 -0500
Subject: 2.5.1 compile error
From: "Martin A. Brooks" <martin@jtrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nUZT6xUn+yYUlaXzMVje"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 10:12:58 +0000
Message-Id: <1008583978.6860.8.camel@unhygienix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nUZT6xUn+yYUlaXzMVje
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686   -c -o init/do_mounts.o init/do_mounts.c
init/do_mounts.c: In function `rd_load_image':
init/do_mounts.c:491: `rd_image_start' undeclared (first use in this
function)
init/do_mounts.c:491: (Each undeclared identifier is reported only once
init/do_mounts.c:491: for each function it appears in.)
make: *** [init/do_mounts.o] Error 1

--=20
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com

--=-nUZT6xUn+yYUlaXzMVje
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8HcUqwgE0gTKdDoYRArtmAJ9BjqT40Mnap0/myMsGcYQ9zQa4qQCcCxGF
pPwFkKupM74wiXHiDpFJsmY=
=KxRj
-----END PGP SIGNATURE-----

--=-nUZT6xUn+yYUlaXzMVje--

