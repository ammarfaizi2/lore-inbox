Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUFZQPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUFZQPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUFZQPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:15:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56223 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267185AbUFZQPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:15:00 -0400
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       george@galis.org
In-Reply-To: <Pine.LNX.4.58.0406260855080.14449@ppc970.osdl.org>
References: <1088253429.9831.1449.camel@cube>
	 <1088262728.2805.7.camel@laptop.fenrus.com>
	 <Pine.LNX.4.58.0406260855080.14449@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QEaBi8jc6Cdg2xfxSe12"
Organization: Red Hat UK
Message-Id: <1088266485.2805.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Jun 2004 18:14:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QEaBi8jc6Cdg2xfxSe12
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 at 18:00, Linus Torvalds wrote:
> On Sat, 26 Jun 2004, Arjan van de Ven wrote:
> >=20
> > well.... this value is *passed to userspace* via the AT_ attributes ...=
.
> > glibc probably nicely exports this info via sysconf(). I guess/hope you=
r
> > tools are now using that ?
>=20
> Even then, it's a bug in my opinion.

Agreed 100%. It gets kind of fun though if you have say 32 bit emulation
in a 64 bit kernel and the 64 bit environment has a different user HZ
than the 32 bit env....



--=-QEaBi8jc6Cdg2xfxSe12
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3aD1xULwo51rQBIRAiZ7AJkB98YJm/05l8mDFBBwHaDYYXBBAACgh1JO
CwvreQ0iV49AwaUUeNCguDI=
=K7xQ
-----END PGP SIGNATURE-----

--=-QEaBi8jc6Cdg2xfxSe12--

