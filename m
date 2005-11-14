Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVKNUXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVKNUXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKNUWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:22:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:6343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932090AbVKNUTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:44 -0500
Date: Mon, 14 Nov 2005 12:06:05 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       pavel@ucw.cz
Subject: [patch 09/12] USB: kill unneccessary usb-storage blacklist entries
Message-ID: <20051114200605.GJ2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-storage-blacklist-entry-removal.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
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

--- gregkh-2.6.orig/drivers/usb/storage/unusual_devs.h	2005-11-02 11:37:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/storage/unusual_devs.h	2005-11-02 12:02:58.000000000 -0800
@@ -710,11 +710,6 @@
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
