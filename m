Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270150AbTGSPnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270083AbTGSPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:41:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:21408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270217AbTGSPkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:40:04 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <105863009030@kroah.com>
Subject: [PATCH] i2c driver changes 2.6.0-test1
In-Reply-To: <20030719155233.GA11754@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 19 Jul 2003 08:54:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1310.80.1, 2003/06/24 14:58:09-07:00, nikkne@hotpop.com

[PATCH] I2C: fix Kconfig info


 drivers/i2c/Kconfig |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Sat Jul 19 08:48:43 2003
+++ b/drivers/i2c/Kconfig	Sat Jul 19 08:48:43 2003
@@ -20,9 +20,7 @@
 	  interfaces", below.
 
 	  If you want I2C support, you should say Y here and also to the
-	  specific driver for your bus adapter(s) below.  If you say Y to
-	  "/proc file system" below, you will then get a /proc interface which
-	  is documented in <file:Documentation/i2c/proc-interface>.
+	  specific driver for your bus adapter(s) below.
 
 	  This I2C support is also available as a module.  If you want to
 	  compile it as a module, say M here and read

