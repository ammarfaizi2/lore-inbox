Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUATAOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUATAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:14:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:25772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265130AbUATAAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:10 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567642211@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:24 -0800
Message-Id: <1074556764412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.18, 2004/01/16 14:12:54-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-i801 help


 drivers/i2c/busses/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:29:51 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:29:51 2004
@@ -73,12 +73,13 @@
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset is supported:
+	  versions of the chipset are supported:
 	    82801AA
 	    82801AB
 	    82801BA
 	    82801CA/CAM
 	    82801DB
+	    82801EB
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.

