Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVJ2LHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVJ2LHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVJ2LHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:07:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14464 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750940AbVJ2LHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:07:14 -0400
Date: Sat, 29 Oct 2005 12:07:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] type fix in arm/boot/compressed/misc.c
Message-ID: <20051029110711.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	spot the typo...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/arch/arm/boot/compressed/misc.c current/arch/arm/boot/compressed/misc.c
--- RC14-base/arch/arm/boot/compressed/misc.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/arm/boot/compressed/misc.c	2005-10-28 20:57:14.000000000 -0400
@@ -30,7 +30,7 @@
 #define putstr icedcc_putstr
 #define putc icedcc_putc
 
-extern void idedcc_putc(int ch);
+extern void icedcc_putc(int ch);
 
 static void
 icedcc_putstr(const char *ptr)
