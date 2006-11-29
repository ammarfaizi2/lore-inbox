Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967395AbWK2Xb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967395AbWK2Xb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967397AbWK2Xb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:31:59 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:39949 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967395AbWK2Xb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:31:58 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Denis Oliver Kropp <dok@directfb.org>
Subject: [PATCH] video: neofb stray bracket fix
Date: Thu, 30 Nov 2006 00:31:26 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300031.26789.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This code is '#if 0'ed. Anyway if anyone wants to dump neo registers
better to have it fixed.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/video/neofb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/drivers/video/neofb.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/video/neofb.c	2006-11-29 15:25:42.000000000 +0100
@@ -1932,7 +1932,7 @@ static int __devinit neo_init_hw(struct 
 	printk(KERN_DEBUG "--- Neo extended register dump ---\n");
 	for (int w = 0; w < 0x85; w++)
 		printk(KERN_DEBUG "CR %p: %p\n", (void *) w,
-		       (void *) vga_rcrt(NULL, w);
+		       (void *) vga_rcrt(NULL, w));
 	for (int w = 0; w < 0xC7; w++)
 		printk(KERN_DEBUG "GR %p: %p\n", (void *) w,
 		       (void *) vga_rgfx(NULL, w));


-- 
Regards,

	Mariusz Kozlowski
