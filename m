Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVBTO6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVBTO6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:58:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:17334 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261842AbVBTO4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:56:33 -0500
Date: Sun, 20 Feb 2005 15:56:20 +0100 (MET)
Message-Id: <200502201456.j1KEuKH6029535@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-rc3-mm2] perfctr-2.7.10 API update 3/4: x86_64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.10 update, 3/4:
- Update x86_64 syscall table for perfctr-2.7.10 API changes.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/asm-x86_64/unistd.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -rupN linux-2.6.11-rc3-mm2/include/asm-x86_64/unistd.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-x86_64-syscalls-update/include/asm-x86_64/unistd.h
--- linux-2.6.11-rc3-mm2/include/asm-x86_64/unistd.h	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-x86_64-syscalls-update/include/asm-x86_64/unistd.h	2005-02-20 13:15:32.000000000 +0100
@@ -567,11 +567,9 @@ __SYSCALL(__NR_keyctl, sys_keyctl)
 __SYSCALL(__NR_vperfctr_open, sys_vperfctr_open)
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
 __SYSCALL(__NR_vperfctr_control, sys_vperfctr_control)
-#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
-__SYSCALL(__NR_vperfctr_unlink, sys_vperfctr_unlink)
-#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
-__SYSCALL(__NR_vperfctr_iresume, sys_vperfctr_iresume)
-#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
+#define __NR_vperfctr_write	(__NR_vperfctr_open+2)
+__SYSCALL(__NR_vperfctr_write, sys_vperfctr_write)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+3)
 __SYSCALL(__NR_vperfctr_read, sys_vperfctr_read)
 
 #define __NR_syscall_max __NR_vperfctr_read
