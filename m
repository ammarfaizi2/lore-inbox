Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSCDLYe>; Mon, 4 Mar 2002 06:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSCDLYY>; Mon, 4 Mar 2002 06:24:24 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:35085 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S291193AbSCDLYM>;
	Mon, 4 Mar 2002 06:24:12 -0500
Date: Mon, 4 Mar 2002 14:28:24 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swapfile.c
Message-ID: <20020304112824.GA279@pazke.ipt>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200203022125.VAA144817.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <UTC200203022125.VAA144817.aeb@cwi.nl>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A1=D0=B1=D1=82, =D0=9C=D0=B0=D1=80 02, 2002 at 09:25:16 +0000, Andri=
es.Brouwer@cwi.nl wrote:
> In 2.5.2 swapfile.c was broken:
> In sys_swapon() we see
>=20
> 	swap_file =3D filp_open(name, O_RDWR, 0);
> 	if (IS_ERR(swap_file))
> 		goto bad_swap_2;
>=20
> bad_swap_2:
> 	...
> 	if (swap_file)
> 		filp_close(swap_file, NULL);
>=20
> and this oopses the kernel.

Fixed in -dj tree.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8g1pYBm4rlNOo3YgRAtb+AJ0SE9fCVrlKtw9eZk5lKlqT+cieawCeN/CT
JbxjMQvcNp5AUeUryg+HFnE=
=5neu
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
