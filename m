Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbULCTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbULCTfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbULCTcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:32:18 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:26628
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262486AbULCTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:30:11 -0500
Message-Id: <200412032146.iB3LkFZW004735@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - declare ptrace_setfpregs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:46:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a declaration for ptrace_setfpregs

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/ptrace_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/ptrace_user.h	2004-12-01 13:23:50.000000000 -0500
+++ 2.6.9/arch/um/include/ptrace_user.h	2004-12-01 13:30:21.000000000 -0500
@@ -11,6 +11,7 @@
 extern int ptrace_getregs(long pid, unsigned long *regs_out);
 extern int ptrace_setregs(long pid, unsigned long *regs_in);
 extern int ptrace_getfpregs(long pid, unsigned long *regs_out);
+extern int ptrace_setfpregs(long pid, unsigned long *regs);
 extern void arch_enter_kernel(void *task, int pid);
 extern void arch_leave_kernel(void *task, int pid);
 extern void ptrace_pokeuser(unsigned long addr, unsigned long data);

