Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbUJ2AqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbUJ2AqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUJ2AnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:43:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2567 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263248AbUJ2A30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:29:26 -0400
Date: Fri, 29 Oct 2004 02:28:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dbrownell@users.sourceforge.net
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] usbnet.c: remove an unused function
Message-ID: <20041029002850.GD29142@stusta.de>
References: <20041028232455.GK3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028232455.GK3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from drivers/usb/net/usbnet.c


diffstat output:
 drivers/usb/net/usbnet.c |    6 ------
 1 files changed, 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c.old	2004-10-28 23:32:50.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c	2004-10-28 23:33:23.000000000 +0200
@@ -2127,12 +2127,6 @@
 }
 
 static inline int
-pl_clear_QuickLink_features (struct usbnet *dev, int val)
-{
-	return pl_vendor_req (dev, 1, (u8) val, 0);
-}
-
-static inline int
 pl_set_QuickLink_features (struct usbnet *dev, int val)
 {
 	return pl_vendor_req (dev, 3, (u8) val, 0);
