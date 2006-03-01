Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWCAXOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWCAXOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCAXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:14:06 -0500
Received: from mx.laposte.net ([81.255.54.11]:8527 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1751116AbWCAXOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:14:04 -0500
Subject: Re: LibPATA code issues / 2.6.15.4
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: Mark Lord <liml@rtr.ca>
Cc: edmudama@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4405F471.8000602@rtr.ca>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L1x6wvIlvZb/A+XfyMMy"
Organization: Adresse perso
Date: Thu, 02 Mar 2006 00:12:42 +0100
Message-Id: <1141254762.11543.10.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 (2.5.92-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L1x6wvIlvZb/A+XfyMMy
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le mercredi 01 mars 2006 =C3=A0 14:22 -0500, Mark Lord a =C3=A9crit :
> Nicolas Mailhot wrote:
> >>
> > How about the drives that got blacklisted following :
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D5914 ?
> > and
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951 ?
> >=20
> > Device Model:     Maxtor 6L300S0
> > Firmware Version: BANC1G10
> >=20
> > on Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controll=
er (rev 02)
>=20
> Mmm.. somebody with one of those controllers should check
> to see if *any* drives work with FUA, and blacklist the controller
> instead of the drives if everything is failing.

I'm a someone with such a controller (that's my boog here)
But I only have these drives.
So I can only confirm the combo it deadly.
(I could possibly try to plug one on the nforce4 controller, not sure if
extracting the box from the tangle of cables and hardware he's part of
is worth it. sata_nv is rev-eng, while the siI docs are public, right?)

I do suspect Eric D. Mudama knows if the problem is on the hard-drive
side though

Regards,

--=20
Nicolas Mailhot

--=-L1x6wvIlvZb/A+XfyMMy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iEYEABECAAYFAkQGKmoACgkQI2bVKDsp8g0veQCggJkweq1nQn7YNSEIobOHitk0
QXsAn0TnHI/6LBG9nezBnS0MTskLml0W
=s1TM
-----END PGP SIGNATURE-----

--=-L1x6wvIlvZb/A+XfyMMy--

