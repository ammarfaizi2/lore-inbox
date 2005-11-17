Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVKQSLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVKQSLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVKQSEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:6562 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932472AbVKQSED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:03 -0500
Date: Thu, 17 Nov 2005 09:47:24 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       balatka@email.cz
Subject: [patch 10/22] USB: cp2101.c: Jablotron usb serial interface identification
Message-ID: <20051117174723.GK11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-cp2101-new-id.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Balatka <balatka@email.cz>

Jablotron usb serial interface identification

Signed-off-by: Josef Balatka <balatka@email.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/serial/cp2101.c |    1 +
 1 file changed, 1 insertion(+)

--- usb-2.6.orig/drivers/usb/serial/cp2101.c
+++ usb-2.6/drivers/usb/serial/cp2101.c
@@ -60,6 +60,7 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(0x10C4, 0x80F6) }, /* Suunto sports instrument */
 	{ USB_DEVICE(0x10A6, 0xAA26) }, /* Knock-off DCU-11 cable */
 	{ USB_DEVICE(0x10AB, 0x10C5) },	/* Siemens MC60 Cable */
+	{ USB_DEVICE(0x16D6, 0x0001) }, /* Jablotron serial interface */
 	{ } /* Terminating Entry */
 };
 

--
