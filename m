Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTEEMz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTEEMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:55:29 -0400
Received: from iucha.net ([209.98.146.184]:52590 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S262169AbTEEMz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:55:26 -0400
Date: Mon, 5 May 2003 08:07:56 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030505130756.GH1059@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030505043058.GG1059@iucha.net> <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cfJ13FhsvNR/yOpm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cfJ13FhsvNR/yOpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2003 at 09:41:10PM -0700, Linus Torvalds wrote:
>=20
> On Sun, 4 May 2003, Florin Iucha wrote:
> >=20
> > On SIS 735 motherboard, with agpgart, sis-agp and radeon loaded, I get
> > this on the serial console before the machine freezes:
> >    agpgart: Found an AGP 2.0 compliant device.
> >    agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
> >    agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
> > Without these modules loaded, the machine is stable.
>=20
> Make sure to also test with regular 1x AGP (and no fast write stuff etc).=
=20
> A lot of motherboards really aren't going to like 4x and some other=20
> settings (in particular, enabling fast writes seems to be a very iffy=20
> proposition indeed).

On your suggestion I did use AGPMode 1 and 2. No difference.

> Also, check if the same setup is stable under 2.4.x and possibly using the
> DRI CVS tree. Radeon in particular seems to be a lot stabler in DRI these=
=20
> days than it has historically been.

The machine was stable in 2.5.30 - 2.5.40 timeframe, using DRI modules
=66rom DRI nightly builds on top of XFree 4.2 . Direct rendering was
working as well.

I will try with the DRI modules again.

Thank you,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--cfJ13FhsvNR/yOpm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tmIsNLPgdTuQ3+QRAjSCAKCVLfjgOIX1Gx/y5XHCeifGUxeYBQCdF1Hi
KHoOh2rNNlgm2vpERzhUh4Y=
=Vxcs
-----END PGP SIGNATURE-----

--cfJ13FhsvNR/yOpm--
