Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTIXDaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbTIXD3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:29:48 -0400
Received: from dp.samba.org ([66.70.73.150]:20428 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261723AbTIXD30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:29:26 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Fix comment in parse_hex_value
Date: Wed, 24 Sep 2003 12:50:45 +1000
Message-Id: <20030924032926.4485D2C56E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  <adobriyan@mail.ru>


--- trivial-2.6.0-test5-bk10/arch/i386/kernel/irq.c.orig	2003-09-24 12:27:14.000000000 +1000
+++ trivial-2.6.0-test5-bk10/arch/i386/kernel/irq.c	2003-09-24 12:27:14.000000000 +1000
@@ -904,7 +904,7 @@
 		return -EFAULT;
 
 	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
+	 * Parse the first HEX_DIGITS characters as a hex string, any non-hex char
 	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
 	 */
 
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= <adobriyan@mail.ru>: [PATCH] Fix comment in parse_hex_value
