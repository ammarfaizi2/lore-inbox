Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTHNKmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTHNKmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:42:15 -0400
Received: from mail.donpac.ru ([217.107.128.190]:26333 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S272275AbTHNKmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:42:13 -0400
Date: Thu, 14 Aug 2003 14:42:08 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: we don't need VGA console !
Message-ID: <20030814104208.GA7457@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.2 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I think subject is self explaining :)

BTW does PC-9800 need VGA console ?

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-visws-2.6.0-test3"

diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/drivers/video/console/Kconfig linux-2.6.0-test3/drivers/video/console/Kconfig
--- linux-2.6.0-test3.vanilla/drivers/video/console/Kconfig	Sat Aug  9 08:33:56 2003
+++ linux-2.6.0-test3/drivers/video/console/Kconfig	Thu Aug 14 22:49:02 2003
@@ -7,7 +7,7 @@
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
 	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
-	default y
+	default y if !X86_VISWS
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually

--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/O2d/by9O0+A2ZecRAkWxAJwPWO+ky5T7woAllruOV2desD2UuQCgjV1X
AulUueUoFxQy5i7nWFKk5iI=
=G2PF
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
