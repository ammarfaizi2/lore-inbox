Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132949AbRAYWbw>; Thu, 25 Jan 2001 17:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbRAYWbm>; Thu, 25 Jan 2001 17:31:42 -0500
Received: from adsl-216-103-8-57.dsl.sndg02.pacbell.net ([216.103.8.57]:7948
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S132949AbRAYWbg>; Thu, 25 Jan 2001 17:31:36 -0500
Date: Thu, 25 Jan 2001 14:31:27 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Message-ID: <20010125143127.F1659@one-eyed-alien.net>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A709E99.25ADE5F6@echostar.com> <94q96s$9b2$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <94q96s$9b2$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Jan 25, 2001 at 02:26:36PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It occurs to me that it might be a good idea to pick a different port for
these things.  I know a lot of people who want to use port 80h for
debugging data, especially in embedded x86 systems.

Matt

On Thu, Jan 25, 2001 at 02:26:36PM -0800, H. Peter Anvin wrote:
> Followup to:  <3A709E99.25ADE5F6@echostar.com>
> By author:    "Ian S. Nelson" <ian.nelson@echostar.com>
> In newsgroup: linux.dev.kernel
> >
> > I'm curious.  Why does Linux make that friendly 98/9a/88 looking
> > postcode pattern when it's running?  DOS and DOS95 don't do that.
> >=20
> > I'm begining to feel like I can tell the system health by observing it,
> > kind of like "seeing the matrix."
> >=20
>=20
> It output garbage to the 80h port in order to enforce I/O delays.
> It's one of the safe ports to issue outs to.
>=20
> 	-hpa
> --=20
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I say, what are all those naked people doing?
					-- Big client to Stef
User Friendly, 12/14/1997

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6cKk/z64nssGU+ykRAvAFAJ45kd4bWZI0fhBCC4jYrQYkIMeMdwCg0scE
wgKTv2Sl50mPfQOiNd8tB6g=
=UQGT
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
