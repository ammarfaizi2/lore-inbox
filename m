Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVIZE0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVIZE0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIZE0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:26:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61896 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932368AbVIZE0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:26:04 -0400
Date: Mon, 26 Sep 2005 05:25:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] missing asm/irq.h (cs89x0)
Message-ID: <20050926042559.GM7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-ppc-arch/drivers/net/cs89x0.c RC14-rc2-git5-cs89x0/drivers/net/cs89x0.c
--- RC14-rc2-git5-ppc-arch/drivers/net/cs89x0.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git5-cs89x0/drivers/net/cs89x0.c	2005-09-25 23:46:54.000000000 -0400
@@ -140,6 +140,7 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
+#include <asm/irq.h>
 #if ALLOW_DMA
 #include <asm/dma.h>
 #endif
