Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUJQQWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUJQQWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJQQPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:15:32 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:24965 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269186AbUJQQKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:10:02 -0400
Subject: [PATCH 7/8] replacing/fixing printk with pr_debug/pr_info in
	include/asm-i386 - apic.h
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032577.3023.130.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:11:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strip the custom debug Dprintk macro.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/include/asm-i386/apic.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-i386/apic.h	2004-10-17 16:57:56.742039840 +0200
+++ linux-2.6.9-rc4/include/asm-i386/apic.h	2004-10-17 17:01:16.869615824 +0200
@@ -7,7 +7,6 @@
 #include <asm/apicdef.h>
 #include <asm/system.h>
 
-#define Dprintk(x...)
 
 /*
  * Debugging macros


