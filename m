Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUBFLIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUBFLIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:08:41 -0500
Received: from legolas.restena.lu ([158.64.1.34]:47837 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265415AbUBFLIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:08:37 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <1076062051.16107.49.camel@athlonxp.bradney.info>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>
	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de>
	 <1076062051.16107.49.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9Cpx3WRdEFWTth8JlN9s"
Message-Id: <1076065711.14357.53.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 12:08:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9Cpx3WRdEFWTth8JlN9s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 11:07, Craig Bradney wrote:
> On Fri, 2004-02-06 at 10:26, Prakash K. Cheemplavam wrote:
> > Craig Bradney wrote:
> > > On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
> > >=20
> > >>>There is a way to "activate" cpu Disconnect? or it gets enabled by=20
> > >>>simply applying it?
> > >>
> > >>In newer Abit BIOSes there is an option, or you use athcool.
> > >>
> > >>
> > >>
> > >>>Yes, I have a Abit motherboards, perhaps it's the problem with the b=
ios.
> > >>
> > >>I have an Abit NF7-S Rev2 with latest Bios.
> > >=20
> > >=20
> > > As noted in my last post.. you dont NEED athcool OR Disconnect to get
> > > stability..=20
> > >=20
> > > I've only ever run athcool to check the status.. and my BIOS doesnt h=
ave
> > > disconnect.
> > >=20
> > > A7N8X Deluxe V2 BIOS 1007.. 11 days uptime here.. haven had a crash
> > > since Ross released those patches ages ago.
> >=20
> > WITHOUT Disconnect my System is stable, but hotter when idle, so that i=
s=20
> > not the point. Ross wanted the patched to work with APIC and Disconnect=
.
> >=20
> > DO you guys use APIC (not ACPI)? I use both APIC (and local APIC) and=20
> > ACPI. ACPI is not the problem (unless they break something...) but APIC=
=20
> > and CPU Disconnect makes trouble on nforce2.
>=20
> athcool reports:
> nVIDIA nForce2 (10de 01e0) found
> 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.
>=20
> I have never used athcool to turn it off, and I don't have a BIOS
> option. APIC, local APIC and ACPI are all on.
>=20

I have to add there were some issues found with the patches I'm using
relating to timing.. (because that is in effect most of the problem).
The issue was with the PC clock losing time but I never noticed it
because I run ntpd anyway.

Craig

--=-9Cpx3WRdEFWTth8JlN9s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAI3Wvi+pIEYrr7mQRAsVWAKCc8HiKpPhqgYKygdVt109K0vFVpACfROGu
QiZsTVamOsK2ML95HVo2ivs=
=W365
-----END PGP SIGNATURE-----

--=-9Cpx3WRdEFWTth8JlN9s--

