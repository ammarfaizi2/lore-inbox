Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261870AbSJFRJ4>; Sun, 6 Oct 2002 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSJFRJ4>; Sun, 6 Oct 2002 13:09:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261870AbSJFRJy>; Sun, 6 Oct 2002 13:09:54 -0400
Subject: PATCH: 2.5.40 fix comment in mca
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:06:52 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yErk-0001rU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/arch/i386/kernel/mca.c linux.2.5.40-ac5/arch/i386/kernel/mca.c
--- linux.2.5.40/arch/i386/kernel/mca.c	2002-10-02 21:33:55.000000000 +0100
+++ linux.2.5.40-ac5/arch/i386/kernel/mca.c	2002-10-02 21:37:04.000000000 +0100
@@ -106,6 +106,8 @@
 /*
  * Motherboard register spinlock. Untested on SMP at the moment, but
  * are there any MCA SMP boxes?
+ *
+ * Yes - Alan
  */
 static spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
 
