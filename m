Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVBGPkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVBGPkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVBGPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:40:44 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:51728 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVBGPj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:39:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NMPE9J3YQ6u4RXdVgewPvq17DprQV8xUpledr7Gutj8WcuRCNuW2SclE/Ww68hkgVqxMKk4rgxwmTedwjBrwmfhsXwlU4JCAVMh/6XY7cqWhII+K+Jfq/RFksrNmLbHFt5zW9G+dvBfLvfQSWsWTd1EZ3ZOXNLPsyjVmSWZwCB8=
Date: Mon, 7 Feb 2005 16:42:26 +0100
From: Mikkel Krautz <krautz@gmail.com>
To: vojtech@ucw.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050207154226.GA4742@omnipotens.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of kernel-parameters.txt:

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---
--- clean/Documentation/kernel-parameters.txt
+++ dirty/Documentation/kernel-parameters.txt
@@ -73,6 +73,7 @@
 	SWSUSP	Software suspension is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
+	USBHID	USB Human Interface Device support is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
@@ -1393,6 +1394,9 @@
 			Format: <io>,<irq>
 
 	usb-handoff	[HW] Enable early USB BIOS -> OS handoff
+
+	usbhid.mousepoll=
+			[USBHID] The interval at wich mice are to be polled at.
  
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.


