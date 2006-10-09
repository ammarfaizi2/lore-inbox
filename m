Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWJICsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWJICsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 22:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWJICr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 22:47:59 -0400
Received: from xenotime.net ([66.160.160.81]:27822 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751623AbWJICr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 22:47:58 -0400
Date: Sun, 8 Oct 2006 19:44:29 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: fix function name in usercopy.c
Message-Id: <20061008194429.c98d7387.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc function name in usercopy.c.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/lib/usercopy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc1g3.orig/arch/i386/lib/usercopy.c
+++ linux-2619-rc1g3/arch/i386/lib/usercopy.c
@@ -179,7 +179,7 @@ __clear_user(void __user *to, unsigned l
 EXPORT_SYMBOL(__clear_user);
 
 /**
- * strlen_user: - Get the size of a string in user space.
+ * strnlen_user: - Get the size of a string in user space.
  * @s: The string to measure.
  * @n: The maximum valid length
  *


---
