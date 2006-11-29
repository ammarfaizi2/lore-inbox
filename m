Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967567AbWK2THj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967567AbWK2THj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967569AbWK2THj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:07:39 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:47621 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967567AbWK2THi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:07:38 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] arm26/init.c broken macro removal
Date: Wed, 29 Nov 2006 20:07:06 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292007.06478.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Broken makro / dead code removal.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 init.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/arch/arm26/mm/init.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/arm26/mm/init.c	2006-11-29 19:51:14.000000000 +0100
@@ -34,8 +34,6 @@
 #include <asm/map.h>
 
 
-#define TABLE_SIZE	PTRS_PER_PTE * sizeof(pte_t))
-
 struct mmu_gather mmu_gathers[NR_CPUS];
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];

-- 
Regards,

	Mariusz Kozlowski
