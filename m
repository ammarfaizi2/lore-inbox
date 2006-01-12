Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWALEPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWALEPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWALEPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16098 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965024AbWALEPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:37 -0500
Subject: [PATCH -mm 9/10] unshare system call -v5 : system call
	registration for ppc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039010.7488.220.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:11:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 9/10] unshare system call: system call registration for ppc

Registers system call for the ppc architecture.

Changes since -v4 of this patch submitted on 12/13/05:
        - Forward ported to 2.6.15-mm3 which modified the syscall number.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 misc.S |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp 2.6.15-mm3/arch/ppc/kernel/misc.S 2.6.15-mm3+unsh-ppc/arch/ppc/kernel/misc.S
--- 2.6.15-mm3/arch/ppc/kernel/misc.S	2006-01-11 20:21:46.000000000 +0000
+++ 2.6.15-mm3+unsh-ppc/arch/ppc/kernel/misc.S	2006-01-12 00:44:16.000000000 +0000
@@ -1403,3 +1403,4 @@ _GLOBAL(sys_call_table)
 	.long sys_inotify_init		/* 275 */
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_unshare


