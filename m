Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSLJPUm>; Tue, 10 Dec 2002 10:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSLJPUm>; Tue, 10 Dec 2002 10:20:42 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:55264 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S262289AbSLJPUl>; Tue, 10 Dec 2002 10:20:41 -0500
Date: Tue, 10 Dec 2002 16:28:20 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.20-BK] usbnet typo
Message-ID: <20021210162820.G18849@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in the latest usbnet driver which disables
the compile of iPAQ specific code. 

With the attached patch, the new driver recognises the iPAQ
and even works :*)

Stelian.

===== drivers/usb/usbnet.c 1.17 vs edited =====
--- 1.17/drivers/usb/usbnet.c	Thu Dec  5 15:06:42 2002
+++ edited/drivers/usb/usbnet.c	Tue Dec 10 16:06:24 2002
@@ -160,7 +160,7 @@
 #define	CONFIG_USB_GENESYS
 #define	CONFIG_USB_NET1080
 #define	CONFIG_USB_PL2301
-#define	CONFIG_USB_SA1110
+#define	CONFIG_USB_SA1100
 #define	CONFIG_USB_ZAURUS
 
 
-- 
Stelian Pop <stelian@popies.net>
