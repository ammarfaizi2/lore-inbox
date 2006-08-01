Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWHALNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWHALNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWHALF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60124 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932634AbWHALFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:32 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 12/33] x86_64: fixup indentation in e820.c
Date: Tue,  1 Aug 2006 05:03:27 -0600
Message-Id: <1154430236814-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/e820.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
index e56c2ad..61f029f 100644
--- a/arch/x86_64/kernel/e820.c
+++ b/arch/x86_64/kernel/e820.c
@@ -205,8 +205,8 @@ unsigned long __init e820_end_of_ram(voi
 		if (start >= end)
 			continue;
 		if (ei->type == E820_RAM) { 
-		if (end > end_pfn<<PAGE_SHIFT)
-			end_pfn = end>>PAGE_SHIFT;
+			if (end > end_pfn<<PAGE_SHIFT)
+				end_pfn = end>>PAGE_SHIFT;
 		} else { 
 			if (end > end_pfn_map<<PAGE_SHIFT) 
 				end_pfn_map = end>>PAGE_SHIFT;
-- 
1.4.2.rc2.g5209e

