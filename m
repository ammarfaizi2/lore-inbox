Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVCOSTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVCOSTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCOSSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:18:53 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:3484 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261721AbVCOSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:12:51 -0500
Date: Tue, 15 Mar 2005 11:12:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Serial fix for PAL4
Message-ID: <20050315181246.GU8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PAL4's bit to <asm-ppc/serial.h>

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -urN linux-2.6.11/include/asm-ppc/serial.h linuxppc-2.6.11/include/asm-ppc/serial.h
--- linux-2.6.11/include/asm-ppc/serial.h	2005-03-02 00:38:26.000000000 -0700
+++ linuxppc-2.6.11/include/asm-ppc/serial.h	2005-03-15 09:00:44.000000000 -0700
@@ -22,6 +22,8 @@
 #include <platforms/mcpn765.h>
 #elif defined(CONFIG_MVME5100)
 #include <platforms/mvme5100.h>
+#elif defined(CONFIG_PAL4)
+#include <platforms/pal4_serial.h>
 #elif defined(CONFIG_PRPMC750)
 #include <platforms/prpmc750.h>
 #elif defined(CONFIG_PRPMC800)

-- 
Tom Rini
http://gate.crashing.org/~trini/
