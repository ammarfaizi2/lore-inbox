Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVDFNVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVDFNVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVDFNVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:21:05 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:14817 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262203AbVDFNS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:18:58 -0400
Date: Wed, 6 Apr 2005 22:18:38 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc2-mm1] mips: remove #include <linux/audit.h> two
 times
Message-Id: <20050406221838.1c730ad7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #include <linux/audit.h>.
Because it includes two times.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc2-mm1-orig/arch/mips/kernel/ptrace.c rc2-mm1/arch/mips/kernel/ptrace.c
--- rc2-mm1-orig/arch/mips/kernel/ptrace.c	Tue Apr  5 23:19:16 2005
+++ rc2-mm1/arch/mips/kernel/ptrace.c	Tue Apr  5 23:27:50 2005
@@ -26,7 +26,6 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 #include <linux/security.h>
-#include <linux/audit.h>
 
 #include <asm/cpu.h>
 #include <asm/fpu.h>


