Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUEJMH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUEJMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUEJMHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:07:25 -0400
Received: from legolas.restena.lu ([158.64.1.34]:46237 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264647AbUEJMHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:07:16 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <200405102137.11468.ross@datscreative.com.au>
References: <200405102137.11468.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ckArD5ycp4QaMDDhYbjY"
Message-Id: <1084190822.8242.46.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 14:07:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ckArD5ycp4QaMDDhYbjY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-10 at 13:37, Ross Dickson wrote:
> Craig Bradney wrote
>=20
> >Well.. 2.6.6 is released.. and THANK YOU Linus and all the patch=20
> > writers.. we have nforce2 fixes in the released kernel now. I'm just=20
> > waiting for a gentoo-dev-sources release now..=20
> >=20
> >
> >
> >Craig=20
>=20
> MOMENT PLEASE.
> ALMOST complete nforce2 support. Job not done yet.

I was waiting for that...

> Unfortunately 2.6.6 still has the old check_timer code which inhibits
> nmi_watchdog=3D1 on all nforce2 from working by having timer_ack=3D1
> when checking io-apic pit routing.
>=20
> It is a hardware issue - NOT A BUGGY BIOS ISSUE inside the integrated=20
> nforce2 interrupt routing.
>=20
> To my understanding IT WILL NEVER BE FIXED BY A BIOS REVISION and=20
> after reading the 8259 datasheets I think it is a mistake within the
> existing code to have the timer_ack on there in the first place.=20
>=20
> I would still like to see Maciej's check_timer patch in the kernel. It wa=
s
> pulled after only a single user mobo complaint was posted yet it helps
> both nforce2 and ibm bios pc's. To my knowledge little effort was made
> by that user to accomodate the patch - it was just outright pulled in spi=
te
> of its benefit to others?
>=20
> Who do we ask to revisit this? Linus? the io-apic.c maintainer? or the on=
e
> user with a complaint?
>=20
> That patch that was dropped by Linus? after appearing in 2.6.3-mm3.=20
> For those nforce2 users with problems of clock skew with the timer into p=
in0
> routing, that patch gave a virtual wire timer routing which worked well.

Why was it dropped?

> It also works around serious problems for ibm users who also want it in.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html

It looks like theres IDE caching problems with the new flushing
mechanism on Maxtor 8mb cache drives.. of which I have 2, so, looks like
I'm awaiting 2.6.7 now anyway or a patch to remove it.

Craig

--=-ckArD5ycp4QaMDDhYbjY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAn3Bmi+pIEYrr7mQRApMEAJ93k3QK/OaoX0d8B1dkyjxztZtyfACfShkA
czglwHVuz1KxAwdGzy6hvIU=
=GdtR
-----END PGP SIGNATURE-----

--=-ckArD5ycp4QaMDDhYbjY--

