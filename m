Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUATC2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUATAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:07:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:8620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264405AbUASX7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:47 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567602050@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:20 -0800
Message-Id: <10745567603666@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.7, 2004/01/14 11:19:14-08:00, khali@linux-fr.org

[PATCH] I2C: Typo in i2c/busses/Kconfig

Another simple patch for your collection. BTW I don't think that i2c-rpx
can be used in 2.6 since it relies on an algorithm that hasn't been
ported yet.


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:32:11 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:32:11 2004
@@ -187,7 +187,7 @@
 	  will be called i2c-prosavage.
 
 config I2C_RPXLITE
-	tristate "Embedded Planet RPX Lite/Classic suppoort"
+	tristate "Embedded Planet RPX Lite/Classic support"
 	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
 
 config I2C_SAVAGE4

