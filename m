Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUG0QbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUG0QbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUG0QaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:30:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:36273 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266208AbUG0Q1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:27:40 -0400
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
From: Jon Oberheide <jon@oberheide.org>
To: Joel Soete <soete.joel@tiscali.be>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Jacobowitz <dan@debian.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FB87C400003E92@ocpmta3.freegates.net>
References: <40FB87C400003E92@ocpmta3.freegates.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MJT3SPwA1t537xsdwKyQ"
Date: Tue, 27 Jul 2004 12:31:24 -0400
Message-Id: <1090945884.30149.1.camel@dionysus>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MJT3SPwA1t537xsdwKyQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-27 at 17:59 +0200, Joel Soete wrote:
> Marcelo,
>=20
> Thanks first for your attention.
> Sorry also for delaying this works but I was a bit busy elsewhere.
>=20
> > -- Original Message --
> > Date: Tue, 27 Jul 2004 09:54:32 -0300
> > From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> > To: Joel Soete <soete.joel@tiscali.be>
> > Cc: Daniel Jacobowitz <dan@debian.org>,
> > 	Vojtech Pavlik <vojtech@suse.cz>,
> > 	Linux Kernel <linux-kernel@vger.kernel.org>
> > Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
> >=20
> >=20
> > On Mon, Jul 05, 2004 at 01:59:21PM +0200, Joel Soete wrote:
> > > Hello Daniel,
> > >=20
> > > > > So just use
> > > > >
> > > > > 	buffer++;
> > > > >
> > > > > here, and the intent is then clear.
>=20
> > > >
> > > > Except C does not actually allow incrementing a void pointer, since
> > > > void does not have a size.
> > > That make better sense to me because aifair a void * was foreseen to
> pass
> > > any kind of type * as actual parameter?
> > > (So as far as I understand, the aritthm pointer sould be dynamic for
> the
> > > best 'natural' behaviour?)
> > >=20
> > > >   You can't do arithmetic on one either.  GNU
> > > > C allows this as an extension.
> > > >
> > > > It's actually this, IIRC:
> > > >   buffer =3D ((char *) buffer) + 1;
> >=20
> > Joel,=20
> >=20
> > It seems the current code is working perfectly, generating correct
> > asm code.=20
> >=20
> > Could you come up with a good enough reason to do this cleanup (as far
> as
> >=20
> > I am concerned) in 2.4.x series?
> >=20
> My first attention was to cleanup some warning of type "use of cast expre=
ssion
> as lvalue is deprecated"
> with gcc-3.3.4. But afaik, right now, there are just few warning which di=
dn't
> break the asm code.

FYI, lvalue casts are treated as errors in gcc 3.5.

Regards,
Jon Oberheide

--=20
Jon Oberheide <jon@oberheide.org>
GnuPG Key: 1024D/F47C17FE
Fingerprint: B716 DA66 8173 6EDD 28F6  F184 5842 1C89 F47C 17FE

--=-MJT3SPwA1t537xsdwKyQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBoNcWEIcifR8F/4RAmS9AJkB04xCUrVGYUQ/yiuUWweaSbOXKQCg2PAS
isWFkfIwCBoubBTINZhr3Fc=
=0+Qc
-----END PGP SIGNATURE-----

--=-MJT3SPwA1t537xsdwKyQ--

