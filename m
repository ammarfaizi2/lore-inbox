Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVBXMgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVBXMgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVBXMgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:36:48 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:21443 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262311AbVBXMgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:36:46 -0500
Subject: Re: [PATCH] Determine SCx200 CB address at run-time
From: Henrik Brix Andersen <brix@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1109163214.12284.2.camel@sponge.fungus>
References: <1109163214.12284.2.camel@sponge.fungus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IuBp/n/s5pOk0p5cOwyU"
Organization: Gentoo Linux
Date: Thu, 24 Feb 2005 13:36:43 +0100
Message-Id: <1109248603.12001.7.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IuBp/n/s5pOk0p5cOwyU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-23 at 13:53 +0100, Henrik Brix Andersen wrote:
> The current SCx200 drivers use a fixed base address of 0x9000 for the
> Configuration Block, but some systems (at least the Soekris net4801)
> uses a base address of 0x6000. This patch first tries the fixed address
> then - if no configuration block could be found - tries the address
> written to the Configuration Block Address Scratchpad register by the
> BIOS.
>=20
> Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

I see that this didn't make it into linux-2.6.11-rc5. Please re-consider
for -rc6 as the SCx200 drivers are useless on Soekris Engineering
hardware without this patch.

Sincerely,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-IuBp/n/s5pOk0p5cOwyU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCHcpbv+Q4flTiePgRAmIIAJ97sEYyptLXaGO8od1mnCCtiPe90gCeI2gW
pZwVgN1bMqb8fZ5LIT1SC2s=
=wRVL
-----END PGP SIGNATURE-----

--=-IuBp/n/s5pOk0p5cOwyU--

