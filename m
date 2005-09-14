Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbVINLuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVINLuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbVINLuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:50:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932734AbVINLuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:50:13 -0400
Subject: Re: [PATCH 2/2] New Omnikey Cardman 4000 driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Harald Welte <laforge@gnumonks.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43280793.8070809@stesmi.com>
References: <20050913155333.GZ29695@sunbeam.de.gnumonks.org>
	 <20050914022314.35eab48d.akpm@osdl.org>  <43280793.8070809@stesmi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hnhafcmxTtey2yKRQnCM"
Organization: Red Hat, Inc.
Date: Wed, 14 Sep 2005 07:42:25 -0400
Message-Id: <1126698145.3159.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hnhafcmxTtey2yKRQnCM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 at 13:20 +0200, Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Andrew Morton wrote:
> > Harald Welte <laforge@gnumonks.org> wrote:
> >=20
> >>Add new Omnikey Cardman 4000 smartcard reader driver
> >=20
> >=20
> > - All the open-coded mdelays() are wrong:
> >=20
> >   #define	T_10MSEC	msecs_to_jiffies(10)
> >   ...
> > 		mdelay(T_10MSEC);
> >=20
> >   mdelay() already takes a jiffies argument.
>=20
> And isn't that what he's doing?

Andrew had a slippian freud; mdelay takes miliseconds as argument.



--=-hnhafcmxTtey2yKRQnCM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKAyhpv2rCoFn+CIRAk09AJ9aOpx0c7xhbb61KAxmdAqqupLDrQCeK6gl
Zzu9ZNAl6NK37KX+Kh4iK3I=
=xuF/
-----END PGP SIGNATURE-----

--=-hnhafcmxTtey2yKRQnCM--

