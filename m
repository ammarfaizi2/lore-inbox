Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVALXLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVALXLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVALW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:58:41 -0500
Received: from t9-123.gprs.mtsnet.ru ([213.87.9.123]:58755 "EHLO
	www.e1.bmstu.ru") by vger.kernel.org with ESMTP id S261551AbVALW6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:58:04 -0500
From: JustMan <justman@e1.bmstu.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.8.1] atmel_cs: Add support LG LW2100N WLAN PCMCIA card
Date: Thu, 13 Jan 2005 01:57:06 +0300
User-Agent: KMail/1.6.2
References: <200501121807.25358.justman@e1.bmstu.ru> <200501130018.34181.justman@e1.bmstu.ru> <41E597EE.9020403@pobox.com>
In-Reply-To: <41E597EE.9020403@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Simon Kelley <simon@thekelleys.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200501130157.06026.justman@e1.bmstu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch add  support LG LW2100N 11Mbps WLAN PCMCIA card 

Signed-Off-By: Serge A. Suchkov <justman@e1.bmstu.ru>

diff -uNrp linux-2.6.8.1/drivers/net/wireless/atmel_cs.orig.c linux-2.6.8.1/drivers/net/wireless/atmel_cs.c
--- linux-2.6.8.1/drivers/net/wireless/atmel_cs.orig.c  2005-01-13 01:21:26.000000000 +0300
+++ linux-2.6.8.1/drivers/net/wireless/atmel_cs.c       2005-01-12 04:06:41.000000000 +0300
@@ -344,7 +344,8 @@ static struct { 
        { 0, 0, "CNet/CNWLC 11Mbps Wireless PC Card V-5", "atmel_at76c502e%s.bin", "CNet CNWLC-811ARL" },
        { 0, 0, "Wireless/PC_CARD", "atmel_at76c502d%s.bin", "Planet WL-3552" },
        { 0, 0, "OEM/11Mbps Wireless LAN PC Card V-3", "atmel_at76c502%s.bin", "OEM 11Mbps WLAN PCMCIA Card" },
-       { 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
+       { 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" },
+       { 0, 0, "LG/LW2100N", "atmel_at76c502e%s.bin", "LG LW2100N 11Mbps WLAN PCMCIA Card" }
 };
 
 /* This is strictly temporary, until PCMCIA devices get integrated into the device model. */


