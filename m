Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVKQSKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVKQSKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKQSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:10:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:24226 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932461AbVKQSEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:12 -0500
Date: Thu, 17 Nov 2005 09:47:11 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       pavel@ucw.cz
Subject: [patch 09/22] USB: kill unneccessary usb-storage blacklist entries
Message-ID: <20051117174711.GJ11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-storage-blacklist-entry-removal.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

I actually have this device, and kernel reports blacklist entry is no
longer neccessary.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/usb/storage/unusual_devs.h |    5 -----
 1 file changed, 5 deletions(-)

--- usb-2.6.orig/drivers/usb/storage/unusual_devs.h
+++ usb-2.6/drivers/usb/storage/unusual_devs.h
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
