Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUJ1WYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUJ1WYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUJ1WYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:24:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263068AbUJ1WVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:21:11 -0400
Date: Fri, 29 Oct 2004 00:20:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Gauthron <chrisg@0-in.com>, greg@kroah.com, phil@netroedge.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i2c it87.c: remove an unused function
Message-ID: <20041028222039.GO3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/i2c/chips/it87.c


diffstat output:
 drivers/i2c/chips/it87.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c.old	2004-10-28 23:00:26.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c	2004-10-28 23:00:37.000000000 +0200
@@ -56,13 +56,6 @@
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
 
- -static inline void
- -superio_outb(int reg, int val)
- -{
- -	outb(reg, REG);
- -	outb(val, VAL);
- -}
- -
 static inline int
 superio_inb(int reg)
 {


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXC3mfzqmE8StAARAnheAJ4oIAZ/LT/MvhtbLjQpkCokdnkCzQCeMUx+
0hf83OAbIcIyj95pPV3hUWg=
=AgjG
-----END PGP SIGNATURE-----
