Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267055AbRGSI2x>; Thu, 19 Jul 2001 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbRGSI2o>; Thu, 19 Jul 2001 04:28:44 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:38414 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S267055AbRGSI22>;
	Thu, 19 Jul 2001 04:28:28 -0400
Date: Thu, 19 Jul 2001 12:28:26 +0400
To: Martin Vogt <mvogt@rhrk.uni-kl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.6 segfault in scsi sr.c
Message-ID: <20010719122826.A10075@orbita1.ru>
In-Reply-To: <20010719095750.B36012@rhrk.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010719095750.B36012@rhrk.uni-kl.de>; from mvogt@rhrk.uni-kl.de on Thu, Jul 19, 2001 at 09:57:50AM +0200
X-Uptime: 12:05pm  up 2 days,  2:41,  2 users,  load average: 0.03, 0.07, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2-acl
From: pazke@orbita1.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2001 at 09:57:50AM +0200, Martin Vogt wrote:
>=20
>=20
> In line 604 begins a switch statement:
>=20
>                 switch (sector_size) {
>                 case 0:  =20

WILD GUESS: why not insert 'case 2336:' here ?

>                 case 2340:
>                 case 2352:
>                         sector_size =3D 2048;
>                         /* fall through */
>                 case 2048:
>                         scsi_CDs[i].capacity *=3D 4;
>                         /* fall through */
>                 case 512:
>                         break;
>                 default:
> kernel message -->      printk("sr%d: unsupported sector size %d.\n",

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7VpopBm4rlNOo3YgRAoLyAKCBjD/kVzkecl5s5MuXo93gP+JDJQCfUH0L
XZdHetwnC+Y4n8Goh7bgG4U=
=SnJX
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
