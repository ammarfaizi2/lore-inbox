Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTKERhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTKERhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:37:45 -0500
Received: from D71e5.d.pppool.de ([80.184.113.229]:696 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263056AbTKERhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:37:41 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Daniel Egger <degger@fhm.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1067896476.692.36.camel@gaston>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ChXNSSkHfqOeGJeke7CE"
Message-Id: <1067976347.945.4.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 21:05:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ChXNSSkHfqOeGJeke7CE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, den 03.11.2003 schrieb Benjamin Herrenschmidt um 22:54:

> > Interesting, will try. I've a whole bunch of more pressing problems wit=
h
> > my new baby, though. X is completely broken, no matter which X modeline=
s
> > I configure I get nothing but sizzle on the screen, it seems that the
> > mode setup for the LVDS with the 9600 Mobility is bork.

Just checked. It doesn't work with the  latest (Linus) 2.6-test and
radeonfb. Do you have any special patches in your tree for radeonfb?

BTW: It took me quite a while to figure out that the only working image
with yaboot was the zImage.chrp. The normal vmlinux doesn't contain a
valid ELF signature (according to yaboot) and the seemingly obvious
vmlinux.elf-pmac goes boom while trying to decompress the kernel.

--=20
Servus,
       Daniel

--=-ChXNSSkHfqOeGJeke7CE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qAaachlzsq9KoIYRAoGfAKC5IuOE/TTsBFY9xvPn81WstmMEFgCeIow9
MD7Sf6Ldp8zg9xTOxsyEMEk=
=jfj1
-----END PGP SIGNATURE-----

--=-ChXNSSkHfqOeGJeke7CE--

