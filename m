Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUGATog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUGATog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUGATog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:44:36 -0400
Received: from wblv-236-224.telkomadsl.co.za ([165.165.236.224]:29383 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266234AbUGAToc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:44:32 -0400
Subject: Re: binutils woes
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040701190720.C8389@flint.arm.linux.org.uk>
References: <20040701175231.B8389@flint.arm.linux.org.uk>
	 <20040701174731.GD15960@smtp.west.cox.net>
	 <20040701190720.C8389@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lmMirlLG12ILKgqTYFq5"
Message-Id: <1088711048.8875.5.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 21:44:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lmMirlLG12ILKgqTYFq5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-01 at 20:07, Russell King wrote:
> On Thu, Jul 01, 2004 at 10:47:31AM -0700, Tom Rini wrote:
> > On Thu, Jul 01, 2004 at 05:52:31PM +0100, Russell King wrote:
> >=20
> > > Hi guys,
> > >=20
> > > On ARM, we appear to have somewhat of a problem with binutils.  At
> > > least the following binutils suffer from a problem whereby it is
> > > possible to create programs which contain undefined symbols:
> > [snip]
> > > I think the only way we can ensure kernel correctness is to add a
> > > subsequent stage to kbuild such that whenever we generate a final
> > > program, we grep the 'nm' output for undefined symbols.
> > >=20
> > > Comments?
> >=20
> > Is there a version of binutils that really does get things right?  If
> > so, can't you Just Say No to older versions and force people to upgrade
> > (with a simple testcase done upfront) ?
>=20
> I've just tested:
>=20
>  GNU assembler 2.15.90 20040409
>  Copyright 2002 Free Software Foundation, Inc.
>  This program is free software; you may redistribute it under the terms o=
f
>  the GNU General Public License.  This program has absolutely no warranty=
.
>  This assembler was configured for a target of `arm-linux'.
>=20

You might try (which should be on any kernel mirror):

GNU assembler 2.15.91.0.1 20040527
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `i686-pc-linux-gnu'.


--=20
Martin Schlemmer

--=-lmMirlLG12ILKgqTYFq5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5GmHqburzKaJYLYRApFkAJ9SEADJoYPj/iXQ1E51OpC+WzbBAQCePo4d
Vr2e29Eeuw1e+7mNx2TwL/U=
=bpnh
-----END PGP SIGNATURE-----

--=-lmMirlLG12ILKgqTYFq5--

