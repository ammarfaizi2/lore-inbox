Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbULNUjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbULNUjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULNUjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:39:00 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:31196 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261653AbULNUir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:38:47 -0500
Date: Tue, 14 Dec 2004 21:38:45 +0100
From: Olaf Hering <olh@suse.de>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][DVB][3/6] update dib-usb driver
Message-ID: <20041214203845.GA21529@suse.de>
References: <41B9C2C7.4070508@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41B9C2C7.4070508@linuxtv.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 10, Michael Hunold wrote:


> - [DVB] added new usb ids for some more clones
> - [DVB] added option to deliver the complete TS with USB2.0 devices
> - [DVB] added support for the dib3000mc/p frontend driver

Small typo in the Kconfig helptext.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9/drivers/media/dvb/dibusb/Kconfig linux-2.6.10-rc3-bk8/drivers/media/dvb/dibusb/Kconfig
--- linux-2.6.9/drivers/media/dvb/dibusb/Kconfig	2004-12-14 21:10:34.000000000 +0100
+++ linux-2.6.10-rc3-bk8/drivers/media/dvb/dibusb/Kconfig	2004-12-14 21:36:42.754209071 +0100
@@ -47,7 +47,7 @@ config DVB_DIBUSB_MISDESIGNED_DEVICES
 	    0x04b4:0x8613 (Artec T1 USB2.0, cold)
 	    0x0574:0x1002 (Artec T1 USB2.0, warm)
 
-	  Say Y if your device one of the mentioned IDs.
+	  Say Y if your device has one of the mentioned IDs.
 
 config DVB_DIBCOM_DEBUG
 	bool "Enable extended debug support for DiBcom USB device"
