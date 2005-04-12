Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVDMBaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVDMBaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDLTy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:54:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:45768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVDLKbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:48 -0400
Message-Id: <200504121031.j3CAVa6Y005352@shell0.pdx.osdl.net>
Subject: [patch 057/198] mips: remove #include <linux/audit.h> two times
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yuasa@hh.iij4u.or.jp,
       ralf@linux-mips.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

This patch removes #include <linux/audit.h>.  Because it includes it two
times.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/mips/kernel/ptrace.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/mips/kernel/ptrace.c~mips-remove-include-linux-audith-two arch/mips/kernel/ptrace.c
--- 25/arch/mips/kernel/ptrace.c~mips-remove-include-linux-audith-two	2005-04-12 03:21:17.046545432 -0700
+++ 25-akpm/arch/mips/kernel/ptrace.c	2005-04-12 03:21:17.049544976 -0700
@@ -26,7 +26,6 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 #include <linux/security.h>
-#include <linux/audit.h>
 
 #include <asm/cpu.h>
 #include <asm/fpu.h>
_
