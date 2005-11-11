Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVKKTZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVKKTZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKKTZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:25:39 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:65261 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751090AbVKKTZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:25:39 -0500
Date: Fri, 11 Nov 2005 17:25:34 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/2] pl2303: adds new IDs.
Message-Id: <20051111172534.4645e0b7.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

This patch adds two new Siemens mobiles IDs for the pl2303 driver.

Thanks.


Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/pl2303.c |    2 ++
 drivers/usb/serial/pl2303.h |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -71,7 +71,9 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(SITECOM_VENDOR_ID, SITECOM_PRODUCT_ID) },
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_ID) },
 	{ USB_DEVICE(SAMSUNG_VENDOR_ID, SAMSUNG_PRODUCT_ID) },
+	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_SX1) },
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_X65) },
+	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_X75) },
 	{ USB_DEVICE(SYNTECH_VENDOR_ID, SYNTECH_PRODUCT_ID) },
 	{ USB_DEVICE( NOKIA_CA42_VENDOR_ID, NOKIA_CA42_PRODUCT_ID ) },
 	{ }					/* Terminating entry */
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -54,7 +54,9 @@
 #define SAMSUNG_PRODUCT_ID	0x8001
 
 #define SIEMENS_VENDOR_ID	0x11f5
+#define SIEMENS_PRODUCT_ID_SX1	0x0001
 #define SIEMENS_PRODUCT_ID_X65	0x0003
+#define SIEMENS_PRODUCT_ID_X75	0x0004
 
 #define SYNTECH_VENDOR_ID	0x0745
 #define SYNTECH_PRODUCT_ID	0x0001


-- 
Luiz Fernando N. Capitulino
