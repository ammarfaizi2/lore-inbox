Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVCBS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVCBS3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBS3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:29:48 -0500
Received: from smtp.gentoo.org ([134.68.220.30]:29588 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262417AbVCBS3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:29:13 -0500
Subject: Re: [PATCH] Resend: Determine SCx200 CB address at run-time
From: Henrik Brix Andersen <brix@gentoo.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109787158.12086.11.camel@sponge.fungus>
References: <1109787158.12086.11.camel@sponge.fungus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UjpzivquCicy3fEipd9I"
Organization: Gentoo Linux
Date: Wed, 02 Mar 2005 19:29:09 +0100
Message-Id: <1109788149.4204.1.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UjpzivquCicy3fEipd9I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-02 at 19:12 +0100, Henrik Brix Andersen wrote:
> The current SCx200 drivers use a fixed base address of 0x9000 for the
> Configuration Block, but some systems (at least the Soekris net4801)
> uses a base address of 0x6000. This patch first tries the fixed address
> then - if no configuration block could be found - tries the address
> written to the Configuration Block Address Scratchpad register by the
> BIOS.
>=20
> This was first sent at Wed, 23 Feb 2005 13:53:33 +0100.
>=20
> Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

Seems like my GPG signature messed up the in-line patch - it's available
from http://dev.gentoo.org/~brix/files/net4801/linux-2.6.11-scx200.patch

Sincerely,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-UjpzivquCicy3fEipd9I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJgX1v+Q4flTiePgRAmx/AKCylIj+8dSXLkpX2flm2DSpkmL6NACcDScu
pa3FlfLt6XUPLdMBhXqtZEw=
=yRft
-----END PGP SIGNATURE-----

--=-UjpzivquCicy3fEipd9I--

