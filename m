Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbUCOXIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUCOXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:06:03 -0500
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:5130 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S262964AbUCOXFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:05:12 -0500
Subject: [PATCH][BUGFIX] : Another Megaraid patch for 2.6 (please apply)
From: Paul Wagland <paul@wagland.net>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, James.Bottomley@HansenPartnership.com, torvalds@osdl.org,
       atulm@lsil.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Tm/NiECbezvmfMooL0je"
Message-Id: <1079392083.3611.8.camel@tidbit.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 00:08:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tm/NiECbezvmfMooL0je
Content-Type: multipart/mixed; boundary="=-22zEPvrBT1B7RcZRmJCl"


--=-22zEPvrBT1B7RcZRmJCl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

This bug was discussed on linux-scsi a few weeks back, but it appears to
have slipped through the cracks. This fix was originally proposed by
Christoph Hellwig, but I am reposting it, since I have the hardware :-)

Anyway, the problem that this fixes is that megaraid doesn't set the
moduler owner for the host_template, this means that the module can be
removed, even when it is in use.

Cheers,
Paul

--=-22zEPvrBT1B7RcZRmJCl
Content-Disposition: attachment; filename=1-megaraid.mod_owner.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=1-megaraid.mod_owner.patch; charset=UTF-8

ZGlmZiAtLXJlY3Vyc2l2ZSAtLWlnbm9yZS1hbGwtc3BhY2UgLS11bmlmaWVkIGxpbnV4LTIuNi4y
Lm8vZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMgbGludXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9z
Y3NpL21lZ2FyYWlkLmMNCi0tLSBsaW51eC0yLjYuMi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5j
CTIwMDQtMDItMDkgMjI6NTY6MDkuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjIubWVn
YXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNC0wMi0yMCAwMTozMjoyMS4wMDAwMDAw
MDAgKzAxMDANCkBAIC00NjE0LDYgKzQ2MTQsNyBAQA0KIH0NCiANCiBzdGF0aWMgc3RydWN0IHNj
c2lfaG9zdF90ZW1wbGF0ZSBtZWdhcmFpZF90ZW1wbGF0ZSA9IHsNCisJLm1vZHVsZQkJCQk9IFRI
SVNfTU9EVUxFLA0KIAkubmFtZQkJCQk9ICJNZWdhUkFJRCIsDQogCS5wcm9jX25hbWUJCQk9ICJt
ZWdhcmFpZCIsDQogCS5pbmZvCQkJCT0gbWVnYXJhaWRfaW5mbywNCg==

--=-22zEPvrBT1B7RcZRmJCl--

--=-Tm/NiECbezvmfMooL0je
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAVjdTtch0EvEFvxURAtNlAKCrWwNoG8c8428YPiXCuEN4wjeCHwCfe4yy
hjxrAUEENSFqslBzLVZIaj4=
=+APf
-----END PGP SIGNATURE-----

--=-Tm/NiECbezvmfMooL0je--

