Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVAPVZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVAPVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAPVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:25:29 -0500
Received: from smtp3.oregonstate.edu ([128.193.0.12]:11478 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262613AbVAPVZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:25:14 -0500
Message-ID: <41EADBB4.9070908@engr.orst.edu>
Date: Sun, 16 Jan 2005 13:25:08 -0800
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, trivial@rustcorp.com.au
Subject: [PATCH][resend] Disable Sidewinder debug messages
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A6E8583548E1A8C935377F5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A6E8583548E1A8C935377F5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorry for the resend (again). Last time I accidently let the patch
line wrap, so this one will actually apply.  This patch is
needed because currently the sidewinder produces a load of
debugging output.

signed-off-by: Michael Marineau <marineam@gentoo.org>

--- linux-2.6.10.orig/drivers/input/joystick/sidewinder.c       2005-01-01 23:06:57.580682749 -0800
+++ linux-2.6.10/drivers/input/joystick/sidewinder.c    2005-01-01 23:08:38.938770296 -0800
@@ -45,7 +45,7 @@
  * as well as break everything.
  */

-#define SW_DEBUG
+/* #define SW_DEBUG */         /* Enable lots of debugging output */

 #define SW_START       400     /* The time we wait for the first bit [400 us] */
 #define SW_STROBE      45      /* Max time per bit [45 us] */


-- 
Michael Marineau
marineam@gentoo.org
Gentoo Linux Developer
Oregon State University

--------------enig9A6E8583548E1A8C935377F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6tu5iP+LossGzjARAlIEAJ9XqCXVvF19xW8U/iyAEOVdPF64vACfZSTq
4xPssoq8cIC6ra5nzDGF2jQ=
=9C50
-----END PGP SIGNATURE-----

--------------enig9A6E8583548E1A8C935377F5--
