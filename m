Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTKIKU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTKIKU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:20:58 -0500
Received: from diale202.ppp.lrz-muenchen.de ([129.187.28.202]:11477 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262315AbTKIKTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:19:12 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Daniel Egger <degger@fhm.edu>
To: benh@kernel.crashing.org
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1068346792.673.25.camel@gaston>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>  <1067976347.945.4.camel@sonja>
	 <1068078504.692.175.camel@gaston>  <1068198639.796.109.camel@sonja>
	 <1068346792.673.25.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9iGDWYH23oAhmSkVBNI1"
Message-Id: <1068371734.797.506.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 10:55:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9iGDWYH23oAhmSkVBNI1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Son, den 09.11.2003 schrieb Benjamin Herrenschmidt um 03:59:

> > Still cannot try this because your kernel wouldn't even survive yaboot.

> Can you give details ? It should work just fine, except if I broke
> something in the past few days when getting G5 support in, but I didn't
> have any other report of this, so...

The report on the chrp image is all I have right now because every other
image will result in a hang right after downloading the kernel via tftp.

Which of the two radeon drivers should I use anyway?

> Well, you are not supposed to use the zImage.chrp on a PowerMac,
> and definitely not from yaboot.

With the Linus kernel it's the only one that works.

> Last I tried, then just netbooting vmlinux.elf-pmac worked fine
> on all the "newworld" models I have here). For yaboot, you need
> to load a plain vmlinux binary.

Yes, but the image is too big for yaboot. I'll have to patch it first.

--=20
Servus,
       Daniel

--=-9iGDWYH23oAhmSkVBNI1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/rg8Wchlzsq9KoIYRAr9OAJkB4CNG/pGcSY+eAlpfZespzwczFwCfaabm
h9WBPfQeDBj4sRF/vfYs3Iw=
=CD/Y
-----END PGP SIGNATURE-----

--=-9iGDWYH23oAhmSkVBNI1--

