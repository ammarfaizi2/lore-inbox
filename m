Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVCDVXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVCDVXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbVCDVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:10:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:17570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263169AbVCDUyj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:39 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Trivial indentation fix in i2c/chips/Kconfig
In-Reply-To: <1109968597146@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685971580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2116, 2005/03/02 16:13:45-08:00, khali@linux-fr.org

[PATCH] I2C: Trivial indentation fix in i2c/chips/Kconfig

Hi Greg,

Quoting myself:

> (...) I also think I see an indentation issue on the "tristate" line,
> seemingly copied from the SENSORS_DS1621 section which would need to
> be fixed as well.

Here is the trivial patch fixing that, if you want to apply it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-04 12:22:39 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-04 12:22:39 -08:00
@@ -63,7 +63,7 @@
 	  will be called asb100.
 
 config SENSORS_DS1621
-      	tristate "Dallas Semiconductor DS1621 and DS1625"
+	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help

