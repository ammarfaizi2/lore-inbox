Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbRFNLwZ>; Thu, 14 Jun 2001 07:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRFNLwO>; Thu, 14 Jun 2001 07:52:14 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:24842 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262094AbRFNLv4>;
	Thu, 14 Jun 2001 07:51:56 -0400
Date: Thu, 14 Jun 2001 15:51:53 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Support for "Yet Another Sound Blaster 16"
Message-ID: <20010614155153.A2855@orbita1.ru>
Reply-To: pazke@orbita1.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
User-Agent: Mutt/1.0.1i
X-Uptime: 3:31pm  up 14 days, 23:13,  1 user,  load average: 0.00, 0.03, 0.00
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patch to add yet another Sound Blaster 16 variant reported by
<klink@clouddancer.com>

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-yasb
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/drivers/sound/sb_card.c linux/drivers/sound/sb_card.c
--- linux.vanilla/drivers/sound/sb_card.c	Thu Jun 14 10:12:35 2001
+++ linux/drivers/sound/sb_card.c	Thu Jun 14 10:16:38 2001
@@ -298,6 +298,11 @@
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
 		0,0,0,0,
 		0,1,1,-1},
+	{"Sound Blaster 16",=20
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00ed),=20
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
+		0,0,0,0,
+		0,1,1,-1},
 	{"Sound Blaster Vibra16S",=20
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0051),=20
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001),
@@ -518,6 +523,9 @@
=20
 	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002b),=20
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
+
+	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00ed),=20
+		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
=20
 	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0051),=20
 		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001), 0 },

--dDRMvlgZJXvWKvBx--

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KKVZBm4rlNOo3YgRAiN1AJ9aiBtHq3E5v7eP1LjjiKCFc1efKwCdH1J8
1Z5ETg/SfoR+s5XrdUuc058=
=CXAA
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
