Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbTBRQgI>; Tue, 18 Feb 2003 11:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267862AbTBRQgI>; Tue, 18 Feb 2003 11:36:08 -0500
Received: from adsl-67-123-8-233.dsl.pltn13.pacbell.net ([67.123.8.233]:3552
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S267860AbTBRQgH>; Tue, 18 Feb 2003 11:36:07 -0500
Date: Tue, 18 Feb 2003 08:45:19 -0800
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.62 radeonfb soft cursor
Message-ID: <20030218164519.GA8030@triplehelix.org>
References: <3E5222D3.9060100@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <3E5222D3.9060100@oracle.com>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Me too. I used it as well, however I think James probably has a better=20
solution than this? If not, I bet it would have been committed=20
already..

James what is the final word?

Regards
Josh

On Tue, Feb 18, 2003 at 01:10:59PM +0100, Alessandro Suardi wrote:
> Hi all,
>=20
>   it looks like this one has been forgotten - but it's needed
>   to display a cursor on my Radeon Mobility 7500's framebuffer.
>=20
>  James posted it a while ago, and it always Worked For Me (TM).
>=20
>=20
> Thanks & ciao,
>=20
> --alessandro
>=20
>  "Life is for the living, you've got to be willing
>    A song ain't a song until someone starts singing"
>       (Wallflowers, "Too Late To Quit")

> --- linux/drivers/video/radeonfb.c-2.5.62	2003-01-03 01:31:42.000000000 +=
0100
> +++ linux/drivers/video/radeonfb.c	2003-02-18 12:13:07.000000000 +0100
> @@ -2212,6 +2212,7 @@
>  	.fb_copyarea	=3D cfb_copyarea,
>  	.fb_imageblit	=3D cfb_imageblit,
>  #endif
> +	.fb_cursor	=3D soft_cursor,
>  };
> =20
> =20


--=20
New PGP public key: 0x27AFC3EE

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UmMfT2bz5yevw+4RAnggAJ48NinQANE6uiTmadJdc72Cvw2VxgCeLzHD
gOkHGe5JxXnRTf/aOam2jp0=
=biWN
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
