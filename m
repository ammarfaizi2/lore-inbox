Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272828AbTHKQwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272817AbTHKQuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:50:35 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:2137 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272818AbTHKQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:31 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sort the cache shift options.
Message-Id: <E19mFqr-00068f-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
--- bk-linus/arch/i386/Kconfig	2003-08-06 16:39:02.000000000 +0100
+++ linux-2.5/arch/i386/Kconfig	2003-08-08 00:38:44.000000000 +0100
@@ -322,10 +322,10 @@ config X86_XADD
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8
+	default "7" if MPENTIUM4 || X86_GENERIC
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
