Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUHKW6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUHKW6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUHKW6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:58:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60048 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S268317AbUHKW5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:57:37 -0400
Date: Wed, 11 Aug 2004 15:57:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] Remove CONFIG_SERIAL_8250_MANY_PORTS from Ebony / Ocotea
Message-ID: <20040811225729.GG390@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SERIAL_8250_MANY_PORTS should not be set for these boards, as
they only have 2 serial ports.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.6/arch/ppc/configs/ocotea_defconfig	2004-08-09 16:41:37 -07:00
+++ edited/arch/ppc/configs/ocotea_defconfig	2004-08-11 15:55:55 -07:00
@@ -398,7 +398,7 @@
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_SERIAL_8250_DETECT_IRQ is not set
 # CONFIG_SERIAL_8250_MULTIPORT is not set
--- 1.8/arch/ppc/configs/ebony_defconfig	2004-08-09 16:41:36 -07:00
+++ edited/arch/ppc/configs/ebony_defconfig	2004-08-11 15:55:58 -07:00
@@ -384,7 +384,7 @@
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_SERIAL_8250_DETECT_IRQ is not set
 # CONFIG_SERIAL_8250_MULTIPORT is not set

-- 
Tom Rini
http://gate.crashing.org/~trini/
