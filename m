Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVLMNoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVLMNoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLMNnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:65211 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932208AbVLMNnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:19 -0500
Subject: [PATCH -mm 4/9] unshare system call : system call registration for
	ppc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481304.25431.185.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 4/9] unshare system call: System call registration for ppc
                                                                                
Signed-off-by: Janak Desai
                                                                                

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


