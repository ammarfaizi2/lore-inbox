Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161302AbWBUDsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWBUDsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWBUDsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:10 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:64188 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161302AbWBUDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:06 -0500
Message-Id: <20060221034748.274685000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:29 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [-mm patch 1/8] s/fucn/func/ typo fix
Content-Disposition: inline; filename=fucn-to-func.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

typo fix

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-generic/bitops/atomic.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-mm/include/asm-generic/bitops/atomic.h
===================================================================
--- 2.6-mm.orig/include/asm-generic/bitops/atomic.h
+++ 2.6-mm/include/asm-generic/bitops/atomic.h
@@ -42,7 +42,7 @@ extern raw_spinlock_t __atomic_hash[ATOM
 /*
  * NMI events can occur at any time, including when interrupts have been
  * disabled by *_irqsave().  So you can get NMI events occurring while a
- * *_bit fucntion is holding a spin lock.  If the NMI handler also wants
+ * *_bit function is holding a spin lock.  If the NMI handler also wants
  * to do bit manipulation (and they do) then you can get a deadlock
  * between the original caller of *_bit() and the NMI handler.
  *

--
