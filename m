Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUIARBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUIARBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUIAQyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:54:00 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:9193 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S267338AbUIAQwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:52:49 -0400
Date: Wed, 1 Sep 2004 18:52:44 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] s390 - export copy_in_user
Message-ID: <20040901165244.GA17339@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch exports __copy_in_user_asm for s390. It is used in
xfs.

Bastian

--=20
Dismissed.  That's a Star Fleet expression for, "Get out."
		-- Capt. Kathryn Janeway, Star Trek: Voyager, "The Cloud"

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="copy_in_user.diff"

--- arch/s390/kernel/s390_ksyms.c	2004-08-14 05:37:15.000000000 +0000
+++ arch/s390/kernel/s390_ksyms.c	2004-09-01 16:21:14.000000000 +0000
@@ -29,6 +29,7 @@
 EXPORT_SYMBOL_NOVERS(_sb_findmap);
 EXPORT_SYMBOL_NOVERS(__copy_from_user_asm);
 EXPORT_SYMBOL_NOVERS(__copy_to_user_asm);
+EXPORT_SYMBOL_NOVERS(__copy_in_user_asm);
 EXPORT_SYMBOL_NOVERS(__clear_user_asm);
 EXPORT_SYMBOL_NOVERS(__strncpy_from_user_asm);
 EXPORT_SYMBOL_NOVERS(__strnlen_user_asm);

--envbJBWh7q8WU6mo--

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iEYEARECAAYFAkE1/lwACgkQnw66O/MvCNGsYgCfQ7WekSXwhbErwWHVD9fTQm1j
0ckAn0DI9HnMAyFIq0uZLgwtXLTg2EcA
=x5l1
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
