Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263091AbUJ2Crh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUJ2Crh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUJ2Cof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:44:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263091AbUJ1XZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:25:27 -0400
Date: Fri, 29 Oct 2004 01:24:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dbrownell@users.sourceforge.net
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] usbnet.c: remove an unused function
Message-ID: <20041028232455.GK3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/usb/net/usbnet.c


diffstat output:
 drivers/usb/net/usbnet.c |    6 ------
 1 files changed, 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c.old	2004-10-28 23:32:50.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c	2004-10-28 23:33:23.000000000 +0200
@@ -2127,12 +2127,6 @@
 }
 
 static inline int
- -pl_clear_QuickLink_features (struct usbnet *dev, int val)
- -{
- -	return pl_vendor_req (dev, 1, (u8) val, 0);
- -}
- -
- -static inline int
 pl_set_QuickLink_features (struct usbnet *dev, int val)
 {
 	return pl_vendor_req (dev, 3, (u8) val, 0);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgX/HmfzqmE8StAARAvVCAJ9wqcniAa5kgAtve4KqGdgI+zXx4ACeLPet
/dF6osevC+GlXF3HSbiFWVM=
=nlSX
-----END PGP SIGNATURE-----
