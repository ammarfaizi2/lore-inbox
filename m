Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVLHWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVLHWOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLHWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:14:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33183 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751243AbVLHWOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:14:04 -0500
Subject: [PATCH -mm 4/5] New system call, unshare (ppc)
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134080045.5476.17.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:14:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 4/5] unshare system call: System call registration for ppc

Signed-off-by: Janak Desai


 misc.S |    1 +
 1 files changed, 1 insertion(+)


diff -Naurp 2.6.15-rc5-mm1/arch/ppc/kernel/misc.S
2.6.15-rc5-mm1+unshare-ppc/arch/ppc/kernel/misc.S
--- 2.6.15-rc5-mm1/arch/ppc/kernel/misc.S	2005-12-06 21:05:50.000000000
+0000
+++ 2.6.15-rc5-mm1+unshare-ppc/arch/ppc/kernel/misc.S	2005-12-08
18:57:21.000000000 +0000
@@ -1403,3 +1403,4 @@ _GLOBAL(sys_call_table)
 	.long sys_inotify_init		/* 275 */
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_unshare


