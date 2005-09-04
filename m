Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVIDXuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVIDXuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVIDXuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:50:02 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:40577 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932122AbVIDXaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:35 -0400
Message-Id: <20050904232327.627552000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:29 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-vp7045-whitespace-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 30/54] usb: white space cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

white space cleanup

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/vp7045.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-09-04 22:28:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp7045.c	2005-09-04 22:28:23.000000000 +0200
@@ -164,7 +164,6 @@ static int vp7045_read_eeprom(struct dvb
 	return 0;
 }
 
-
 static int vp7045_read_mac_addr(struct dvb_usb_device *d,u8 mac[6])
 {
 	return vp7045_read_eeprom(d,mac, 6, MAC_0_ADDR);
@@ -256,9 +255,9 @@ static struct dvb_usb_properties vp7045_
 static struct usb_driver vp7045_usb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "dvb_usb_vp7045",
-	.probe 		= vp7045_usb_probe,
+	.probe		= vp7045_usb_probe,
 	.disconnect = dvb_usb_device_exit,
-	.id_table 	= vp7045_usb_table,
+	.id_table	= vp7045_usb_table,
 };
 
 /* module stuff */

--

