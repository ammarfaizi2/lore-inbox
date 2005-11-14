Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVKNUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVKNUWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVKNUVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:21:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:6599 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932096AbVKNUTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:45 -0500
Date: Mon, 14 Nov 2005 12:06:10 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       balatka@email.cz
Subject: [patch 10/12] USB: cp2101.c: Jablotron usb serial interface identification
Message-ID: <20051114200610.GK2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-cp2101-new-id.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
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

--- gregkh-2.6.orig/drivers/usb/serial/cp2101.c	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/serial/cp2101.c	2005-11-02 12:04:11.000000000 -0800
@@ -60,6 +60,7 @@
 	{ USB_DEVICE(0x10C4, 0x80F6) }, /* Suunto sports instrument */
 	{ USB_DEVICE(0x10A6, 0xAA26) }, /* Knock-off DCU-11 cable */
 	{ USB_DEVICE(0x10AB, 0x10C5) },	/* Siemens MC60 Cable */
+	{ USB_DEVICE(0x16D6, 0x0001) }, /* Jablotron serial interface */
 	{ } /* Terminating Entry */
 };
 

--
