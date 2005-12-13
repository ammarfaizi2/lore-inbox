Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVLMW4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVLMW4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbVLMWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:55:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:15021 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030339AbVLMWzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:55:00 -0500
Subject: [PATCH -mm 4/9] unshare system call: system call registration for
	ppc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134514073.11972.188.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
[PATCH -mm 4/9] unshare system call: system call registration for ppc

Registers system call for the ppc architecture.

Changes since the first submission of this patch on 12/12/05:
	None.
 
Signed-off-by: Janak Desai <janak@us.ibm.com>
 
---
 
 misc.S |    1 +
 1 files changed, 1 insertion(+)
 
diff -Naurp 2.6.15-rc5-mm2/arch/ppc/kernel/misc.S 2.6.15-rc5-mm2+ppc/arch/ppc/kernel/misc.S
--- 2.6.15-rc5-mm2/arch/ppc/kernel/misc.S	2005-12-12 03:05:39.000000000 +0000
+++ 2.6.15-rc5-mm2+ppc/arch/ppc/kernel/misc.S	2005-12-12 20:24:32.000000000 +0000
@@ -1406,3 +1406,4 @@ _GLOBAL(sys_call_table)
 	.long sys_ni_syscall
 	.long sys_ni_syscall
 	.long sys_migrate_pages		/* 280 */
+	.long sys_unshare


