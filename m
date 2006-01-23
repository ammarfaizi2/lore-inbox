Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWAWNrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWAWNrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAWNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:47:41 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:64236 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751457AbWAWNrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:47:41 -0500
Date: Mon, 23 Jan 2006 15:47:39 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Get rid of SPI_BUTTERFLY duplication.
Message-ID: <20060123134739.GA4172@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CONFIG_SPI_BUTTERFLY is listed twice in drivers/spi/Kconfig, one will do
fine..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/spi/Kconfig |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b77dbd6..7a75fae 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -75,16 +75,6 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
=20
-config SPI_BUTTERFLY
-	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
-	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
-	select SPI_BITBANG
-	help
-	  This uses a custom parallel port cable to connect to an AVR
-	  Butterfly <http://www.atmel.com/products/avr/butterfly>, an
-	  inexpensive battery powered microcontroller evaluation board.
-	  This same cable can be used to flash new firmware.
-
 #
 # Add new SPI master controllers in alphabetical order above this line
 #

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1N571K+teJFxZ9wRAiaeAJ9C/gKDZ49YlyX33JrPYZU5ZXhnbACeJcui
h0jaAhGR+wyGFmr09FJwoVE=
=XS7e
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
