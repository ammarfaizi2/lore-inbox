Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTA1UCP>; Tue, 28 Jan 2003 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbTA1UCP>; Tue, 28 Jan 2003 15:02:15 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4576
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267671AbTA1UCO>; Tue, 28 Jan 2003 15:02:14 -0500
Date: Tue, 28 Jan 2003 12:11:26 -0800
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59: radeonfb, no visible cursor at the fb console
Message-ID: <20030128201126.GA25318@ludicrus.ath.cx>
References: <20030127220655.GA7650@ttnet.net.tr> <Pine.LNX.4.44.0301281905260.12076-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301281905260.12076-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Why is this different from the block cursor that is seen in 2.4? (this=20
one is a '_' type)

Is it a soft cursor and not the hardware one?

-Josh

On Tue, Jan 28, 2003 at 07:05:34PM +0000, James Simmons wrote:
>=20
> Applied. Thanks.
>=20
> > This trivial patch fixes the cursor problem at radeonfb.c, reported at
> > http://bugme.osdl.org/show_bug.cgi?id=3D292
> >=20
> > --- linux-2.5.59-vanilla/drivers/video/radeonfb.c       Mon Jan 27 23:2=
5:39 2003
> > +++ linux-2.5.59/drivers/video/radeonfb.c       Mon Jan 27 23:44:02 2003
> > @@ -2212,6 +2212,7 @@
> >         .fb_copyarea    =3D cfb_copyarea,
> >         .fb_imageblit   =3D cfb_imageblit,
> >  #endif
> > +       .fb_cursor      =3D  soft_cursor,
> >  };
> >=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+NuPu6TRUxq22Mx4RAnSvAJ9gwu7rpRwXstnYSQ93lo0f06++lQCfeVnR
5uaD3SxpFlF+h0tWPWLm/yo=
=3Qmf
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
