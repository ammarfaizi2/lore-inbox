Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVJaW4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVJaW4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVJaW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:56:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1218 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932496AbVJaW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:56:41 -0500
Date: Mon, 31 Oct 2005 23:56:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: [patch] kill unneccessary usb-storage blacklist entries
Message-ID: <20051031225626.GA4249@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I actually have this device, and kernel reports blacklist entry is no
longer neccessary.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -710,11 +710,6 @@ UNUSUAL_DEV(  0x0686, 0x4017, 0x0001, 0x
                 "DIMAGE E223",
                 US_SC_SCSI, US_PR_DEVICE, NULL, 0 ),
 
-UNUSUAL_DEV(  0x0693, 0x0002, 0x0100, 0x0100, 
-		"Hagiwara",
-		"FlashGate SmartMedia",
-		US_SC_SCSI, US_PR_BULK, NULL, 0 ),
-
 UNUSUAL_DEV(  0x0693, 0x0005, 0x0100, 0x0100,
 		"Hagiwara",
 		"Flashgate",

-- 
Thanks, Sharp!
