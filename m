Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVCBSow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVCBSow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCBSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:44:51 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:19978 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262402AbVCBSor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:44:47 -0500
Date: Wed, 2 Mar 2005 19:45:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.6] Trivial indentation fix in i2c/chips/Kconfig
Message-Id: <20050302194522.2512fe02.khali@linux-fr.org>
In-Reply-To: <cIyC5ZN2.1109756623.5808030.khali@localhost>
References: <4224C0D4.2060303@katalix.com>
	<cIyC5ZN2.1109756623.5808030.khali@localhost>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Quoting myself:

> (...) I also think I see an indentation issue on the "tristate" line,
> seemingly copied from the SENSORS_DS1621 section which would need to
> be fixed as well.

Here is the trivial patch fixing that, if you want to apply it.

Thanks,

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11/drivers/i2c/chips/Kconfig.orig	Wed Mar  2 15:12:34 2005
+++ linux-2.6.11/drivers/i2c/chips/Kconfig	Wed Mar  2 15:15:12 2005
@@ -63,7 +63,7 @@
 	  will be called asb100.
 
 config SENSORS_DS1621
-      	tristate "Dallas Semiconductor DS1621 and DS1625"
+	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help


-- 
Jean Delvare
