Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFUNTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFUNTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFUNTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:19:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261294AbVFUNOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:14:18 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1119357351.3325.124.camel@localhost.localdomain>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119357351.3325.124.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5OQV1n6eoXrrLs4b+uu1"
Organization: Red Hat, Inc.
Date: Tue, 21 Jun 2005 09:07:44 -0400
Message-Id: <1119359264.3035.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5OQV1n6eoXrrLs4b+uu1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 13:35 +0100, Alan Cox wrote:
> On Maw, 2005-06-21 at 07:54, Andrew Morton wrote:
> > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ Kconfigu=
rable.
> >     Will merge (will switch default to 1000 Hz later if that seems nece=
ssary)
>=20
> This has been in Fedora for a while. DaveJ can probably give you more
> info. From own testing 100Hz is how far down you want to go to avoid
> random clock slew on laptops and to see power improvements.

actually 250Hz is a not so fun value. 300 is a lot nicer (multiple of
both 50Hz and 60Hz and thus covers most TV standards)


--=-5OQV1n6eoXrrLs4b+uu1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuBEgpv2rCoFn+CIRAixPAJ49kdOxnZGnkLZ4ub0yf3b9rpFh4wCfe5t/
yFejaCbaR/YIKwSF/1ZS9fo=
=jWG6
-----END PGP SIGNATURE-----

--=-5OQV1n6eoXrrLs4b+uu1--

