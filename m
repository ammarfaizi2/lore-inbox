Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269668AbUINUoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269668AbUINUoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUINUmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:42:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269668AbUINUkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:40:25 -0400
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Denis Zaitsev <zzz@anda.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
References: <20040915021418.A1621@natasha.ward.six>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-diQHIR5KxkBHTSecYg6s"
Organization: Red Hat UK
Message-Id: <1095194406.2698.33.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 22:40:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-diQHIR5KxkBHTSecYg6s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-14 at 22:14, Denis Zaitsev wrote:
> Why this kernel is always compiled with the FP emulation for x86?
> This is the line from the beginning of arch/i386/Makefile:
>=20
> CFLAGS +=3D -pipe -msoft-float
>=20
> And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
> is this just a typo or not?


this is on purpose; this way we get an error if someone uses floating
point in the kernel.... which is BAD

--=-diQHIR5KxkBHTSecYg6s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBR1cmxULwo51rQBIRApt6AKCTWwCCCpUkVrtuSKUjD4wd+m0qtwCeJKvb
MOeMnLUdyI1UeKCrOANdUEY=
=1ANy
-----END PGP SIGNATURE-----

--=-diQHIR5KxkBHTSecYg6s--

