Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVBHVXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVBHVXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVBHVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:23:25 -0500
Received: from smtp08.auna.com ([62.81.186.18]:30701 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261641AbVBHVXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:23:14 -0500
Date: Tue, 08 Feb 2005 21:23:12 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
To: linux-kernel@vger.kernel.org
References: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.61.0502081322310.6118@scrub.home>
	<20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk>
	(from matthew@wil.cx on Tue Feb  8 16:44:17 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1107897792l.21373l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-mnv4RWrVihr7u4j3dMZ6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-mnv4RWrVihr7u4j3dMZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.02.08, Matthew Wilcox wrote:
> On Tue, Feb 08, 2005 at 01:23:48PM +0100, Roman Zippel wrote:
> > Enabling the following in the Makefile should have the same effect:
> >=20
> > # For maximum performance (+ possibly random breakage, uncomment
> > # the following)
> >=20
> > #MAKEFLAGS +=3D -rR
>=20

aic7xxx fails if you select to build firmware and use -R.
-R suppress the variable definitions, so a rule for lex and yacc
is missing and aicasm fails to build.

A rule for lex and yacc could be added somewhere in kbuild...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam8 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-mnv4RWrVihr7u4j3dMZ6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCCS3ARlIHNEGnKMMRAgSNAJ9O94kV5t2zldxv83QyIWL4JEnx6QCfcH5Q
+qH9zHQgq1jteoQRbQ90HZc=
=KUU6
-----END PGP SIGNATURE-----

--=-mnv4RWrVihr7u4j3dMZ6--

