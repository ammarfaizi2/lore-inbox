Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVFANLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFANLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFANLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:11:31 -0400
Received: from mail.renesas.com ([202.234.163.13]:59885 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261303AbVFANKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:10:53 -0400
Date: Wed, 01 Jun 2005 22:10:45 +0900 (JST)
Message-Id: <20050601.221045.179955184.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5-mm1] m32r: Cleanup arch/m32r/mm/extable.c
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just clean up arch/m32r/mm/extable.c.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/arch/m32r/mm/extable.c b/arch/m32r/mm/extable.c
--- a/arch/m32r/mm/extable.c	2004-12-25 06:35:28.000000000 +0900
+++ b/arch/m32r/mm/extable.c	2005-05-30 18:08:19.000000000 +0900
@@ -1,10 +1,8 @@
 /*
- * linux/arch/i386/mm/extable.c
+ * linux/arch/m32r/mm/extable.c
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
@@ -19,4 +17,3 @@ int fixup_exception(struct pt_regs *regs
 
 	return 0;
 }
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
