Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWFSM0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWFSM0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFSMZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932423AbWFSMZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:22 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/15] frv: trivial cleanups in frv_ksyms.c
Date: Mon, 19 Jun 2006 13:25:14 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122514.10060.73876.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Remove duplicate EXPORT_SYMBOL annotations from the FRV arch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/frv_ksyms.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/frv/kernel/frv_ksyms.c b/arch/frv/kernel/frv_ksyms.c
index 0f273a7..dee637f 100644
--- a/arch/frv/kernel/frv_ksyms.c
+++ b/arch/frv/kernel/frv_ksyms.c
@@ -26,16 +26,6 @@ extern long __memset_user(void *dst, con
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strstr);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strncpy);
-
 EXPORT_SYMBOL(ip_fast_csum);
 
 #if 0
@@ -44,8 +34,6 @@ EXPORT_SYMBOL(local_bh_count);
 #endif
 EXPORT_SYMBOL(kernel_thread);
 
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(__res_bus_clock_speed_HZ);
 EXPORT_SYMBOL(__page_offset);
 EXPORT_SYMBOL(__memcpy_user);
@@ -62,18 +50,12 @@ #endif
 
 EXPORT_SYMBOL(__debug_bug_trap);
 
-/* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
-
 /* The following are special because they're not called
    explicitly (the C compiler generates them).  Fortunately,
    their interface isn't gonna change any time soon now, so
    it's OK to leave it out of version control.  */
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memscan);
-EXPORT_SYMBOL(memmove);
 
 EXPORT_SYMBOL(__outsl_ns);
 EXPORT_SYMBOL(__insl_ns);

