Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267097AbUBFA7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267076AbUBFA7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:59:22 -0500
Received: from legolas.restena.lu ([158.64.1.34]:40936 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S267097AbUBFA7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:59:06 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>, Andrew Morton <akpm@osdl.org>,
       david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <4022E3C8.4020704@wanadoo.es>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
	 <4022E3C8.4020704@wanadoo.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jH+amwFIq1gLfwR8Ryrm"
Message-Id: <1076029144.14357.33.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 01:59:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jH+amwFIq1gLfwR8Ryrm
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 01:46, Luis Miguel Garc=EDa wrote:
> Prakash K. Cheemplavam wrote:
>=20
> > Luis Miguel Garc=EDa wrote:
> >
> >> Craig Bradney wrote:
> >>
> >>>
> >>>
> >>>
> >>> One day hopefully this will be sorted in the BIOSes and in mainline. =
I
> >>> keep having to patch for every release (although as thats the only=20
> >>> patch
> >>> I have to do I'm sure there are many worse off than me). I use the 3c=
om
> >>> n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
> >>>
> >>> Best patches are at:
> >>> http://lkml.org/lkml/2003/12/21/7
> >>>
> >>> Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
> >>> issues.
> >>
> >
> > Unfortunately that patch doesn't work for me. Still locks if I try=20
> > APIC +CPU DIsc.
> >
> >>>
> >>> (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cool=
er
> >>> +exhaust fans in box)
> >>>
> >>> Craig
> >>> =20
> >>>
> >> you mean 31 - 38 C readed from /proc/acpi/temp[........]????
> >>
> >> I'm having readings of 53 in idle and even 64 while compiling!! I=20
> >> have no case fan, but I don't think it's so important for this bug=20
> >> difference.
> >
> >
> > The problem is, you cannot trust those infos esp not across board=20
> > manufacturers. In case of Abit nearly every bios shows different=20
> > values...
> >
> > I have an Athon XP running at 2.1Gz with 1.65vcore. Idle: 50=B0C (with=20
> > CPU Disc usually about 44-40=B0C) and under load about 54=B0C. I am usi=
gn=20
> > a more or less self-made watercooling.
> >
> >
> > Prakash
> >
>=20
> There is a way to "activate" cpu Disconnect? or it gets enabled by=20
> simply applying it?
>=20
> Yes, I have a Abit motherboards, perhaps it's the problem with the bios.


I'm not activating Disconnect.. I'm using Ross's latest 2 patches.. one
of them avoids using Disconnect.

Craig

--=-jH+amwFIq1gLfwR8Ryrm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAIubYi+pIEYrr7mQRAhYbAJ9LkePezPB4w35jDQ+pHIms457mNACgnO9/
k27rUEC2Ehr/6ElF5UlxlfE=
=rITC
-----END PGP SIGNATURE-----

--=-jH+amwFIq1gLfwR8Ryrm--

