Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967587AbWK2TbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967587AbWK2TbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967588AbWK2TbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:31:08 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:29192 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967587AbWK2TbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:31:07 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: ralf@linux-mips.org
Subject: [PATCH] mips tx4927 missing brace fix
Date: Wed, 29 Nov 2006 20:30:35 +0100
User-Agent: KMail/1.9.5
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292030.36170.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-11-28 12:16:25.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-11-29 16:07:11.000000000 +0100
@@ -433,7 +433,7 @@ static void __init toshiba_rbtx4927_irq_
 	/* make sure we are looking at IRR (not ISR) */
 	outb(0x0A, 0x20);
 	outb(0x0A, 0xA0);
-
+}
 #endif
 
 


-- 
Regards,

	Mariusz Kozlowski
