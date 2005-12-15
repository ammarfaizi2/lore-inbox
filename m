Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVLOPY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVLOPY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVLOPY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:24:28 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:14032 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750762AbVLOPY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:24:27 -0500
Message-ID: <43A18AB1.2090701@anagramm.de>
Date: Thu, 15 Dec 2005 16:24:33 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] I2C RTC8564/PCF8563 compatibility and century bit
 usage
References: <43A187DC.8010305@anagramm.de>
In-Reply-To: <43A187DC.8010305@anagramm.de>
Content-Type: multipart/mixed;
 boundary="------------020104070606050809030000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020104070606050809030000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add a comment that the Epson RTC8564 i2c real time clock
is compatible to the Philips PCF8563

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
-- 

--------------020104070606050809030000
Content-Type: text/plain;
 name="rtc8654-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc8654-Kconfig.patch"

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f9fae28..705675e 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -66,10 +66,11 @@ config SENSORS_PCF8591
 	  will be called pcf8591.
 
 config SENSORS_RTC8564
-	tristate "Epson 8564 RTC chip"
+	tristate "Epson RTC8564 and Philips PCF8653 RTC chip"
 	depends on I2C && EXPERIMENTAL
 	help
-	  If you say yes here you get support for the Epson 8564 RTC chip.
+	  If you say yes here you get support for the Epson 8564 RTC or
+	  to the compatible Philips PCF8563 chip.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rtc8564.

--------------020104070606050809030000--
