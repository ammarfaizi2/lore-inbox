Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVJCIUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJCIUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVJCIUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:20:46 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:42888 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932184AbVJCIUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:20:46 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20051003082009.31436.83795.sendpatchset@cherry.local>
Subject: [PATCH] i386: remove incorrect PAE comment
Date: Mon,  3 Oct 2005 17:20:45 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect PAE comment.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

--- from-0002/arch/i386/mm/pgtable.c
+++ to-work/arch/i386/mm/pgtable.c	2005-10-03 17:14:38.000000000 +0900
@@ -104,7 +104,7 @@ static void set_pte_pfn(unsigned long va
  * Associate a large virtual page frame with a given physical page frame 
  * and protection flags for that frame. pfn is for the base of the page,
  * vaddr is what the page gets mapped to - both must be properly aligned. 
- * The pmd must already be instantiated. Assumes PAE mode.
+ * The pmd must already be instantiated.
  */ 
 void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags)
 {
