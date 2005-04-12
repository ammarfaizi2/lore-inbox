Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVDMD1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVDMD1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVDLTaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:30:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:12489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262193AbVDLKcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:15 -0400
Message-Id: <200504121032.j3CAW9px005518@shell0.pdx.osdl.net>
Subject: [patch 096/198] x86_64: Remove duplicated syscall entry.
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       blaisorblade@yahoo.it
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-x86_64/unistd.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN include/asm-x86_64/unistd.h~x86_64-remove-duplicated-syscall-entry include/asm-x86_64/unistd.h
--- 25/include/asm-x86_64/unistd.h~x86_64-remove-duplicated-syscall-entry	2005-04-12 03:21:25.949192024 -0700
+++ 25-akpm/include/asm-x86_64/unistd.h	2005-04-12 03:21:25.952191568 -0700
@@ -533,8 +533,6 @@ __SYSCALL(__NR_tgkill, sys_tgkill)
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
-#define __NR_vserver		236
-__SYSCALL(__NR_vserver, sys_ni_syscall)
 #define __NR_mbind 		237
 __SYSCALL(__NR_mbind, sys_mbind)
 #define __NR_set_mempolicy 	238
_
