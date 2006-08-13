Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWHMNRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWHMNRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHMNRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:17:17 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:41889 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751169AbWHMNRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:17:16 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: [PATCH] fix serial/amba-pl011.c console Kconfig
Date: Sun, 13 Aug 2006 15:17:06 +0200
Message-ID: <87fyg0rd0t.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following little trivial patch fixes the Kconfig entry for console
on AMBA PL011 to match the code.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.18-rc4.orig/drivers/serial/Kconfig linux-2.6.18-rc4/drivers/serial/Kconfig
--- linux-2.6.18-rc4.orig/drivers/serial/Kconfig	2006-08-13 15:08:01.000000000 +0200
+++ linux-2.6.18-rc4/drivers/serial/Kconfig	2006-08-13 15:09:37.000000000 +0200
@@ -295,7 +295,7 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  Even if you say Y here, the currently visible framebuffer console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
-	  "console=ttyAM0". (Try "man bootparam" or see the documentation of
+	  "console=ttyAMA0". (Try "man bootparam" or see the documentation of
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 

-- 
Bye, Peter Korsgaard
