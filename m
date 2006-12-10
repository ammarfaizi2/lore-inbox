Return-Path: <linux-kernel-owner+w=401wt.eu-S1760387AbWLJIYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760387AbWLJIYo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760389AbWLJIYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:24:44 -0500
Received: from mx2.brouhaha.com ([64.62.206.8]:46402 "HELO brouhaha.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1760371AbWLJIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:24:44 -0500
Message-ID: <4798.67.111.218.83.1165739063.squirrel@ruckus.brouhaha.com>
Date: Sun, 10 Dec 2006 00:24:23 -0800 (PST)
Subject: [PATCH] usb serial: add support for Novatel S720/U720 CDMA/EV-DO   
        modems
From: "Eric Smith" <eric@brouhaha.com>
To: linux-kernel@vger.kernel.org
Cc: grekkh@suse.de, torvalds@osdl.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from Eric Smith <eric@brouhaha.com

Add USB vendor/device IDs for Novatel Wireless S720 and U720 CDMA/EV-DO
modems to airprime.c.

Signed-off-by: Eric Smith <eric@brouhaha.com>
---

--- airprime.c.orig     2006-12-09 19:48:49.000000000 -0800
+++ airprime.c  2006-12-09 19:49:33.000000000 -0800
@@ -19,6 +19,8 @@
 static struct usb_device_id id_table [] = {
        { USB_DEVICE(0x0c88, 0x17da) }, /* Kyocera Wireless
KPC650/Passport */
        { USB_DEVICE(0x1410, 0x1110) }, /* Novatel Wireless Merlin CDMA */
+       { USB_DEVICE(0x1410, 0x1130) }, /* Novatel Wireless S720
CDMA/EV-DO */
+       { USB_DEVICE(0x1410, 0x2110) }, /* Novatel Wireless U720
CDMA/EV-DO */
        { USB_DEVICE(0x1410, 0x1430) }, /* Novatel Merlin XU870 HSDPA/3G
*/
        { USB_DEVICE(0x1410, 0x1100) }, /* ExpressCard34 Qualcomm 3G CDMA
*/
        { },



