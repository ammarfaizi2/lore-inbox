Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSLWJPB>; Mon, 23 Dec 2002 04:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSLWJPA>; Mon, 23 Dec 2002 04:15:00 -0500
Received: from mail.gmx.net ([213.165.65.60]:46232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265276AbSLWJO7>;
	Mon, 23 Dec 2002 04:14:59 -0500
Date: Mon, 23 Dec 2002 10:23:04 +0100
To: linux-kernel@vger.kernel.org
Subject: compile error in isdn_ppp_mp.h (kernel 2.5.52)
Message-ID: <20021223092303.GB4995@mob.wid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
x-gpg-fingerprint: 717B AE57 49B3 410F A733  FE6A 2D43 E1E3 CF28 6A67
x-gpg-key: wwwkeys.de.pgp.net
From: Felix Triebel <ernte23@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

compiling kernel 2.5.52 stops with this:

gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall -Ws=
trict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe =
-mpreferred-stack-boundary=3D2 -march=3Di686 -malign-functions=3D4 -Iarch/i=
386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include -DMODU=
LE   -DKBUILD_BASENAME=3Disdn_ppp -DKBUILD_MODNAME=3Disdn   -c -o drivers/i=
sdn/i4l/isdn_ppp.o drivers/isdn/i4l/isdn_ppp.c
In file included from drivers/isdn/i4l/isdn_ppp.c:22:
drivers/isdn/i4l/isdn_ppp_mp.h: In function `ippp_mp_xmit':
drivers/isdn/i4l/isdn_ppp_mp.h:47: too many arguments to function `ippp_xmi=
t'
make[4]: *** [drivers/isdn/i4l/isdn_ppp.o] error 1
make[3]: *** [drivers/isdn/i4l] error 2
make[2]: *** [drivers/isdn] error 2
make[1]: *** [drivers] error 2
make: *** [modules] error 2

Is this a known problem?
I just wanted to test 2.5.

regards,
Felix T.

--=20

/"\  ASCII RIBBON CAMPAIGN
\ /  AGAINST HTML MAIL
 X   AND POSTINGS  :)
/ \  http://www.dcoul.de/

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+BtX3LUPh488oamcRAkbRAJ42rv8XM/3XTfIDHGO7GDHhfX5mswCdFEqB
7chWJ269Wzi50DPmUH1aSDg=
=fQJ/
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
