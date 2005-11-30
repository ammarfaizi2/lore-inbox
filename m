Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVK3F7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVK3F7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVK3F7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:59:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:32155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750882AbVK3F6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:58:47 -0500
Cc: davej@redhat.com
Subject: [PATCH] Additional device ID for Conexant AccessRunner USB driver
In-Reply-To: <11333303172787@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 29 Nov 2005 21:58:37 -0800
Message-Id: <1133330317951@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Additional device ID for Conexant AccessRunner USB driver

Reported as working in Fedora bugzilla by Petr.

From: Petr Tuma <petr.tuma@mff.cuni.cz>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d3420ba4930d61f4ec4abc046765de274182b4ed
tree fd76b774f59fb3eae7c0ec428064fce1fd9a3d79
parent 620948a01c71060a32611bc2f792f58a88cf28b1
author Dave Jones <davej@redhat.com> Mon, 28 Nov 2005 13:44:52 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 29 Nov 2005 21:39:22 -0800

 drivers/usb/atm/cxacru.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 79861ee..9d59dc6 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
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

