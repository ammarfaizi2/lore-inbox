Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVAOUkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVAOUkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVAOUkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:40:07 -0500
Received: from smtp1.oregonstate.edu ([128.193.0.11]:16297 "EHLO
	smtp1.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262318AbVAOUkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:40:00 -0500
Message-ID: <41E97F9E.5050109@gentoo.org>
Date: Sat, 15 Jan 2005 12:39:58 -0800
From: Michael Marineau <marineam@gentoo.org>
Organization: Gentoo Linux
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a little pach to disable the sidewinder debug messages.
Sorry for the extra clutter if you have already taken care of this.  I'd
like this to get this moving towards the mainline soon.


signed-off-by: Michael Marineau <marineam@gentoo.org>

- --- linux-2.6.10.orig/drivers/input/joystick/sidewinder.c
2005-01-01 23:06:57.580682749 -0800
+++ linux-2.6.10/drivers/input/joystick/sidewinder.c    2005-01-01
23:08:38.938770296 -0800
@@ -45,7 +45,7 @@
  * as well as break everything.
  */

- -#define SW_DEBUG
+/* #define SW_DEBUG */         /* Enable lots of debugging output */

 #define SW_START       400     /* The time we wait for the first bit
[400 us] */
 #define SW_STROBE      45      /* Max time per bit [45 us] */


- --
Michael Marineau
marineam@gentoo.org
Gentoo Linux Developer
Oregon State University
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6X+eiP+LossGzjARAmxKAKC03xIRsyJwY/hqFsgz8WW1tdzBWQCgge9L
JFzdZwTafcvGmOHQ8n42LJw=
=uwpk
-----END PGP SIGNATURE-----
