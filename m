Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWFDCQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWFDCQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWFDCQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:13 -0400
Received: from [198.99.130.12] ([198.99.130.12]:40109 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751415AbWFDCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:10 -0400
Message-Id: <200606040216.k542GCQ1004827@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/6] UML - Add asm/irqflags.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an empty asm/irqflags.h, which seems to satisfy the lock validator enough
that UML builds.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/include/asm-um/irqflags.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-mm/include/asm-um/irqflags.h	2006-06-01 14:49:26.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_IRQFLAGS_H
+#define __UM_IRQFLAGS_H
+
+/* Empty for now */
+
+#endif

