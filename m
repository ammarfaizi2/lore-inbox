Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVANG2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVANG2K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVANG2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:28:10 -0500
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:45254 "EHLO
	mail27.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261923AbVANG2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:28:06 -0500
Date: Thu, 13 Jan 2005 22:28:04 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in drivers/char/Kconfig
Message-ID: <Pine.LNX.4.58.0501132225001.6614@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patch fixes a typo in the Toshiba entries in the
drivers/char/Kconfig file. Quite trivial.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	2005-01-12 00:13:13.000000000 -0800
+++ b/drivers/char/Kconfig	2005-01-13 22:23:34.000000000 -0800
@@ -352,7 +352,7 @@
 	bool "TX3912/PR31700 serial port support"
 	depends on SERIAL_NONSTANDARD && MIPS && BROKEN_ON_SMP
 	help
-	  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
+	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core;
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
 	  Say Y here to enable kernel support for the on-board serial port.

@@ -360,7 +360,7 @@
 	bool "Console on TX3912/PR31700 serial port"
 	depends on SERIAL_TX3912
 	help
-	  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
+	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core;
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
 	  Say Y here to direct console I/O to the on-board serial port.

