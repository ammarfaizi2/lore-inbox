Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTHWODu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 10:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbTHWODu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 10:03:50 -0400
Received: from [203.145.184.221] ([203.145.184.221]:43275 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262787AbTHWODt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:03:49 -0400
Subject: [2.6.0-test4][TRIVIAL][DOC] kernel-locking.tmpl: typo fix:
	spin_lock_restore
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 19:56:03 +0530
Message-Id: <1061648764.1121.49.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.0-test4/Documentation/DocBook/kernel-locking.tmpl	2003-07-15 17:23:34.000000000 +0530
+++ linux-2.6.0-test4-nvk/Documentation/DocBook/kernel-locking.tmpl	2003-08-23 19:38:42.000000000 +0530
@@ -463,7 +463,7 @@
       <function>spin_lock_irqsave()</function> 
       (<filename>include/linux/spinlock.h</filename>) is a variant
       which saves whether interrupts were on or off in a flags word,
-      which is passed to <function>spin_lock_irqrestore()</function>.  This 
+      which is passed to <function>spin_unlock_irqrestore()</function>.  This 
       means that the same code can be used inside an hard irq handler (where
       interrupts are already off) and in softirqs (where the irq
       disabling is required).



