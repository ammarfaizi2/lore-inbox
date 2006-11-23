Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755532AbWKWD61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbWKWD61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 22:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbWKWD61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 22:58:27 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:23761
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1755532AbWKWD60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 22:58:26 -0500
Message-ID: <45651C66.5050105@saville.com>
Date: Wed, 22 Nov 2006 19:58:30 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix comments for MSR_FS_BASE and MSR_GS_BASE.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comments for MSR_FS_BASE & MSR_GS_BASE were transposed.

Signed-off-by: Wink Saville <wink@saville.com>
---
  include/asm-x86_64/msr.h |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-x86_64/msr.h b/include/asm-x86_64/msr.h
index 37e1941..74c175a 100644
--- a/include/asm-x86_64/msr.h
+++ b/include/asm-x86_64/msr.h
@@ -169,8 +169,8 @@ #define MSR_STAR 0xc0000081         /* legacy m
  #define MSR_LSTAR 0xc0000082           /* long mode SYSCALL target */
  #define MSR_CSTAR 0xc0000083           /* compatibility mode SYSCALL target */
  #define MSR_SYSCALL_MASK 0xc0000084    /* EFLAGS mask for syscall */
-#define MSR_FS_BASE 0xc0000100         /* 64bit GS base */
-#define MSR_GS_BASE 0xc0000101         /* 64bit FS base */
+#define MSR_FS_BASE 0xc0000100         /* 64bit FS base */
+#define MSR_GS_BASE 0xc0000101         /* 64bit GS base */
  #define MSR_KERNEL_GS_BASE  0xc0000102 /* SwapGS GS shadow (or USER_GS from kernel) */
  /* EFER bits: */
  #define _EFER_SCE 0  /* SYSCALL/SYSRET */
--
1.4.2.1

