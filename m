Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVK1So7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVK1So7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVK1So7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:44:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25509 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932174AbVK1So6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:44:58 -0500
Date: Mon, 28 Nov 2005 13:44:52 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, petr.tuma@mff.cuni.cz
Subject: Additional device ID for Conexant AccessRunner USB driver
Message-ID: <20051128184452.GA25570@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, gregkh@suse.de, petr.tuma@mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported as working in Fedora bugzilla by Petr.

From: Petr Tuma <petr.tuma@mff.cuni.cz>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/usb/atm/cxacru.c~	2005-11-28 13:41:15.000000000 -0500
+++ linux-2.6.14/drivers/usb/atm/cxacru.c	2005-11-28 13:41:49.000000000 -0500
@@ -787,6 +787,9 @@ static const struct usb_device_id cxacru
 	{ /* V = Conexant			P = ADSL modem (Hasbani project)	*/
 		USB_DEVICE(0x0572, 0xcb00),	.driver_info = (unsigned long) &cxacru_cb00
 	},
+	{ /* V = Conexant             P = ADSL modem (Well PTI-800 */
+		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
+	},
 	{ /* V = Conexant			P = ADSL modem				*/
 		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
 	},
