Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSAaBcI>; Wed, 30 Jan 2002 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAaBcD>; Wed, 30 Jan 2002 20:32:03 -0500
Received: from zeus.kernel.org ([204.152.189.113]:143 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290809AbSAaBar>;
	Wed, 30 Jan 2002 20:30:47 -0500
Subject: Re: Oops in bdflush with 2.4.1[4|7]-xfs
From: Austin Gonyou <austin@coremetrics.com>
To: Nathan Poznick <poznick@conwaycorp.net>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020130224523.GA26824@conwaycorp.net>
In-Reply-To: <20020130224523.GA26824@conwaycorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-AcpOTpv27WMptG5MMvfV"
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 19:30:33 -0600
Message-Id: <1012440633.15133.9.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AcpOTpv27WMptG5MMvfV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'd agree with Eric that DMAPI could be causing you a problem. I don't
have it on in general.

On Wed, 2002-01-30 at 16:45, Nathan Poznick wrote:
> Thus spake Austin Gonyou:
> > Could you see if my XFS-AA patch does anything for you? There are
> > changes to bdflush in it and I'd be interested to see if they go away.
>=20
> >=20
> > http://www.digitalroadkill.net/Patches/2.4.17-xfs-aa.patch.bz2
>=20
> Unfortunately I can't really do to much messing around with this
> machine right now, it's being used pretty heavily.  Even after bdflush
> died and I needed to bounce the machine, I just about had to beat the
> developers off the machine with a stick. :-)
>=20
> Eric Sandeen suggested turning off DMAPI support, so I'm going to give
> that a try first.  I'll go ahead and grab a copy of your patch, and
> give it a try if the problem still resurfaces.
>=20
> --=20
> Nathan Poznick <poznick@conwaycorp.net>
> PGP Key: http://drunkmonkey.org/pgpkey.txt
>=20
> Boss:   You forgot to assign the result of your map!
> Hacker: Dang, I'm always forgetting my assignations...
> Boss:   And what's that "goto" doing there?!?
> Hacker: Er, I guess my finger slipped when I was typing
> "getservbyport"...
> Boss:   Ah well, accidents will happen.  Maybe we should have picked
> APL.
> -- Larry Wall
--=20
Austin Gonyou
Systems Architect, CCNA
Coremetrics, Inc.
Phone: 512-698-7250
email: austin@coremetrics.com

"It is the part of a good shepherd to shear his flock, not to skin it."
Latin Proverb

--=-AcpOTpv27WMptG5MMvfV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8WJ4594g6ZVmFMoIRAlWkAKC5WmGEmmyepaF4cWu9xF+eRWoAgACgpao1
P3LP7PWxJX3SQ7Vxh08bsuo=
=6dUF
-----END PGP SIGNATURE-----

--=-AcpOTpv27WMptG5MMvfV--
