Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUATACI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUATABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:01:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:11948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264934AbUASX7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:53 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567633048@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:23 -0800
Message-Id: <10745567633966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.15, 2004/01/15 16:05:33-08:00, greg@kroah.com

[PATCH] I2C: remove CONFIG_ISA dependancy for I2C_ISA as x86_64 does not have CONFIG_ISA


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:30 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:30 2004
@@ -108,7 +108,7 @@
 
 config I2C_ISA
 	tristate "ISA Bus support"
-	depends on I2C && ISA && EXPERIMENTAL
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.

