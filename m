Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275443AbTHJBBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275444AbTHJBBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:01:40 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:6857 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S275443AbTHJBBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:01:38 -0400
Date: Sat, 9 Aug 2003 18:01:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       vojtech@suse.cz
Subject: Re: 2.6.0-test3 issue
Message-ID: <20030810010136.GA807@ip68-0-152-218.tc.ph.cox.net>
References: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net> <20030809223358.GA3496@finwe.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20030809223358.GA3496@finwe.eu.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2003 at 12:33:58AM +0200, Jacek Kawa wrote:
> Tom Rini wrote:
>=20
> > Hello.  I just tried to compile up 2.6.0-test3 for my x86 box, and I
> > noticed that the following set of options will no longer work:
> > CONFIG_EMBEDDED=3Dn
> > CONFIG_SERIO=3Dm
> > CONFIG_INPUT_KEYBOARD=3Dy
> > CONFIG_KEYBOARD_ATKBD=3Dy
> >=20
> > The problem is that unless I set CONFIG_EMBEDDED, INPUT_KEYBOARD and
> > KEYBOAD_ATKBD both get set to 'Y', regardless of the other dependancies
> > (such as SERIO being 'm').
>=20
> I think it's:
>=20
> ...
> Alan Cox:
> ...
>   o mouse and keyboard by default if not embedded
> ... =20
>=20
> change.
>=20
> (I was wandering what I had done wrong, that mousedev.ko
> disappeared  8)

Yes, but now the kernel will happily give you a non-linking kernel
because SERIO=3Dm and ATKBD=3Dy is 'valid'.  I don't know if this is a
Kconfig problem, ATKBD defauling to the wrong value, or both.  Or if
it's just a bad change. :)

>=20
> jk
>=20
> --=20
> Jacek Kawa

--=20
Tom Rini
http://gate.crashing.org/~trini/

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NZlwdZngf2G4WwMRAiMbAKCAoU8l0FQvkSCe11bv6zC7DySCNgCfY5rd
Ccg7dn5pYVKk21pOh9hj7lU=
=miCY
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
