Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSKMU4P>; Wed, 13 Nov 2002 15:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSKMU4O>; Wed, 13 Nov 2002 15:56:14 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47343 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263228AbSKMU4M>; Wed, 13 Nov 2002 15:56:12 -0500
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()
From: Arjan van de Ven <arjanv@redhat.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200211132013.gADKDhS01389@linux.intel.com>
References: <200211132013.gADKDhS01389@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BG6qFO44nQDQEsPIM2ja"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 21:46:45 +0100
Message-Id: <1037220406.2889.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BG6qFO44nQDQEsPIM2ja
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-11-13 at 21:13, Rusty Lynch wrote:
> The following is a small patch to the 2.5.47 kernel that adds an exported
> function called valid_kernel_address() that allows kernel code to verify
> a kernel-mapped address is valid.
>=20
> valid_kernel_address just calls the static inline kernel_text_address()
> function defined in arch/i386/kernel/traps.c=20
>=20
it is customary that people who ask for an export explain why they need
it.... would you mind explaining that ?


--=-BG6qFO44nQDQEsPIM2ja
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA90ro1xULwo51rQBIRAu9hAJsF5mt4QMu8TZyv/YzZmmO5E50FtQCcCLqb
jyfZriNqr6xYh7toIb4F3wE=
=RN/p
-----END PGP SIGNATURE-----

--=-BG6qFO44nQDQEsPIM2ja--

