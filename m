Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757510AbWKXCYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbWKXCYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 21:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757571AbWKXCYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 21:24:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757510AbWKXCYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 21:24:00 -0500
Date: Fri, 24 Nov 2006 03:24:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] build the appledisplay driver
Message-ID: <20061124022403.GE28363@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do already have both the code and a config option, so why not build 
this driver?  ;-)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/drivers/usb/misc/Makefile.old	2006-11-24 03:19:31.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/usb/misc/Makefile	2006-11-24 03:20:13.000000000 +0100
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_USB_ADUTUX)	+= adutux.o
+obj-$(CONFIG_USB_APPLEDISPLAY)	+= appledisplay.o
 obj-$(CONFIG_USB_AUERSWALD)	+= auerswald.o
 obj-$(CONFIG_USB_CYPRESS_CY7C63)+= cypress_cy7c63.o
 obj-$(CONFIG_USB_CYTHERM)	+= cytherm.o

