Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTIABMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIABMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:12:07 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:32643
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262567AbTIABL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:11:59 -0400
Date: Sun, 31 Aug 2003 21:11:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] non_fatal.c isn't P4 specific
Message-ID: <Pine.LNX.4.53.0308312110460.9881@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/mcheck/non-fatal.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/mcheck/non-fatal.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 non-fatal.c
--- linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/mcheck/non-fatal.c	30 Aug 2003 23:30:57 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/mcheck/non-fatal.c	31 Aug 2003 23:49:38 -0000
@@ -1,5 +1,5 @@
 /*
- * P4 specific Machine Check Exception Reporting
+ * Non Fatal Machine Check Exception Reporting
  */
 
 #include <linux/init.h>
