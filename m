Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVABDmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVABDmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 22:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVABDmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 22:42:35 -0500
Received: from smtp3.oregonstate.edu ([128.193.0.12]:4324 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261235AbVABDmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 22:42:32 -0500
Message-ID: <41D7AF86.2050000@gentoo.org>
Date: Sun, 02 Jan 2005 00:23:34 -0800
From: Michael Marineau <marineam@gentoo.org>
Organization: Gentoo Linux
User-Agent: Mozilla Thunderbird 1.0 (X11/20041231)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable Sidewinder debug messages
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a little pach to disable the sidewinder debug messages

signed-off-by: Michael Marineau <marineam@gentoo.org>

- --- linux-2.6.10.orig/drivers/input/joystick/sidewinder.c       2005-01-01 23:06:57.580682749 -0800
+++ linux-2.6.10/drivers/input/joystick/sidewinder.c    2005-01-01 23:08:38.938770296 -0800
@@ -45,7 +45,7 @@
  * as well as break everything.
  */

- -#define SW_DEBUG
+/* #define SW_DEBUG */         /* Enable lots of debugging output */

 #define SW_START       400     /* The time we wait for the first bit [400 us] */
 #define SW_STROBE      45      /* Max time per bit [45 us] */


- --
Michael Marineau
marineam@gentoo.org
Gentoo Linux Developer
Oregon State University

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB16+GiP+LossGzjARAkvrAKC7n2sifNEqsyceOYlu/QZwMH3CDwCglNjT
iHZKz0kCwpRIiW56k/+CJFE=
=0ckq
-----END PGP SIGNATURE-----
