Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUJZVhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUJZVhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUJZVhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:37:38 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:53915 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261498AbUJZVhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:37:07 -0400
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20041026231514.GA3285@mars.ravnborg.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
	 <1098824849.12420.60.camel@nosferatu.lan>
	 <20041026231514.GA3285@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tI81W/IhcmBzCMp8goP2"
Date: Tue, 26 Oct 2004 23:36:56 +0200
Message-Id: <1098826616.12420.62.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tI81W/IhcmBzCMp8goP2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 01:15 +0200, Sam Ravnborg wrote:
> On Tue, Oct 26, 2004 at 11:07:29PM +0200, Martin Schlemmer [c] wrote:
> =20
> > > Current patch will not rebuild image if one of the
> > > programs listed are changed. But it should give a good
> > > foundation to do so.
> > >=20
> >=20
> > I will see if I get the time to get that implemented elegantly if
> > you do not beat me to it.
>=20
> Something as simple as putting relevant timestamps in the generated
> file as coment should do it.
> If timestamp differ then initramfs_list will be updated and initramfs
> image will be remade.
>=20
> All changes isolated to gen_initramfs_list.sh.
> Care to give that a spin?
>=20

Yep.  Bit late now, so will only get to it tomorrow though.


--=20
Martin Schlemmer


--=-tI81W/IhcmBzCMp8goP2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBfsN4qburzKaJYLYRAqXsAJ9LD86mtqT/GugZxONCHPi0q9EUJwCePJ7O
fiuPIYh5y7nGnN87J/3Uvgo=
=X/Kp
-----END PGP SIGNATURE-----

--=-tI81W/IhcmBzCMp8goP2--

