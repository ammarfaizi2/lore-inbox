Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbSJBVkb>; Wed, 2 Oct 2002 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJBVka>; Wed, 2 Oct 2002 17:40:30 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:24829 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262618AbSJBVk3>; Wed, 2 Oct 2002 17:40:29 -0400
Subject: PATCH: 2.5 trivial - MCA comments
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 22:53:35 +0100
Message-Id: <1033595616.25240.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/arch/i386/kernel/mca.c linux.2.5.40-ac1/arch/i386/kernel/mca.c
--- linux.2.5.40/arch/i386/kernel/mca.c	2002-10-02 21:33:55.000000000 +0100
+++ linux.2.5.40-ac1/arch/i386/kernel/mca.c	2002-10-02 21:37:04.000000000 +0100
@@ -106,6 +106,8 @@
 /*
  * Motherboard register spinlock. Untested on SMP at the moment, but
  * are there any MCA SMP boxes?
+ *
+ * Yes - Alan
  */
 static spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
 
