Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJGVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJGVHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJGS1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:10 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:22747 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267702AbUJGSYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:24:04 -0400
Subject: [patch 1/1] uml: remove wrong declaration
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 07 Oct 2004 19:55:26 +0200
Message-Id: <20041007175526.E04FC5000@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid compile failure due to the addition of sys_timer_create to linux/syscalls.h

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/sys_call_table.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-remove-wrong-decl arch/um/kernel/sys_call_table.c
--- linux-2.6.9-current/arch/um/kernel/sys_call_table.c~uml-remove-wrong-decl	2004-10-07 19:09:54.946142664 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/sys_call_table.c	2004-10-07 19:09:59.675423704 +0200
@@ -47,7 +47,6 @@ extern syscall_handler_t sys_rt_sigactio
 extern syscall_handler_t sys_sigaltstack;
 extern syscall_handler_t sys_vfork;
 extern syscall_handler_t sys_mmap2;
-extern syscall_handler_t sys_timer_create;
 extern syscall_handler_t old_mmap_i386;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
_
