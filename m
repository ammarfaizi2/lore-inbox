Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUBFA4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267000AbUBFA4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:56:22 -0500
Received: from legolas.restena.lu ([158.64.1.34]:59111 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262827AbUBFA4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:56:18 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: Andrew Morton <akpm@osdl.org>, david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <4022DE3C.1080905@wanadoo.es>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-62D+nPpzhAqQpy1pR+6D"
Message-Id: <1076028975.23667.30.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 01:56:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-62D+nPpzhAqQpy1pR+6D
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 01:22, Luis Miguel Garc=EDa wrote:
> Craig Bradney wrote:
>=20
> >On Fri, 2004-02-06 at 00:40, Andrew Morton wrote:
> > =20
> >
> >>Luis Miguel Garc=EDa <ktech@wanadoo.es> wrote:
> >>   =20
> >>
> >>>David Ford wrote:
> >>>
> >>>     =20
> >>>
> >>>>I have the same problem.  I "solved" it a while ago by mucking with=20
> >>>>the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or=20
> >>>>something similar in cmos.  Went from incredibly broken to stable=20
> >>>>instantly.  I'll check my cmos settings in a bit and refresh my memor=
y.
> >>>>
> >>>>What patches are you using?
> >>>>       =20
> >>>>
> >>>I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that=20
> >>>Andrew Morton have sent to me. I think they have been included in=20
> >>>previous mm kernels but now are droped because they caused some=20
> >>>temperature problems for some people with no nforce motherboards.
> >>>     =20
> >>>
> >>Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnec=
t"
> >>apparently causes the CPU to run hot.
> >>
> >>   =20
> >>
> >>>By the way, is anyone involved in solving the IO-APIC thing in nforce=20
> >>>motherboards? Anyone trying a different approach? Anyone contacting=20
> >>>nvidia about this problem?
> >>>     =20
> >>>
> >>As far as I know, we're dead in the water on these problems.
> >>   =20
> >>
> >
> >
> >One day hopefully this will be sorted in the BIOSes and in mainline. I
> >keep having to patch for every release (although as thats the only patch
> >I have to do I'm sure there are many worse off than me). I use the 3com
> >n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
> >
> >Best patches are at:
> >http://lkml.org/lkml/2003/12/21/7
> >
> >Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
> >issues.
> >
> > (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cooler
> >+exhaust fans in box)
> >
> >Craig
> > =20
> >
> you mean 31 - 38 C readed from /proc/acpi/temp[........]????
>=20
> I'm having readings of 53 in idle and even 64 while compiling!! I have=20
> no case fan, but I don't think it's so important for this bug difference.
>=20
> by the way, has anyone tried to contact nvidia with detailed information=20
> of this bug? Perhaps they can tell us something, not to?


no.. /sys/bus/i2c

I was highly sceptical that these values were wrong.. but if I was to
shut down and immediately look at the BIOS values.. they are close
enough to make the values I'm quoting to be on the mark. Of course, the
BIOS values could be wrong.

I had the normal Athlon cooler and one rear case fan and it was maxing
out at around 50C. Putting on the Zalman cooler dropped it by 10C.
Adding in the rear fans means it never goes above 39C while compiling.
If the windows open and theres a draft through the room and cold
outside.. :) ..it will idle at 29ish.

Craig



--=-62D+nPpzhAqQpy1pR+6D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAIuYvi+pIEYrr7mQRAggJAJ0XuyxjVE8J1FwRth5OykvryNTLeACfUpwT
PSy8fBZ8G4gvpAPxvnwjmsE=
=VTMC
-----END PGP SIGNATURE-----

--=-62D+nPpzhAqQpy1pR+6D--

