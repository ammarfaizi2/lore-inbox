Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758962AbWK2X0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962AbWK2X0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758967AbWK2X0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:26:00 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3599 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1758965AbWK2X0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:26:00 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] video: cyberfb broken macro removal
Date: Thu, 30 Nov 2006 00:25:29 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300025.29514.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes broken and unused macro.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/video/cyberfb.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/drivers/video/cyberfb.c	2006-11-28 12:16:49.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/video/cyberfb.c	2006-11-30 00:18:52.000000000 +0100
@@ -109,8 +109,6 @@ static void cv64_dump(void);
 #define wb_64(regs,reg,dat) (*(((volatile unsigned char *)regs) + reg) = dat)
 #define rb_64(regs, reg) (*(((volatile unsigned char *)regs) + reg))
 
-#define ww_64(regs,reg,dat) (*((volatile unsigned short *)(regs + reg) = dat)
-
 struct cyberfb_par {
 	struct fb_var_screeninfo var;
 	__u32 type;


-- 
Regards,

	Mariusz Kozlowski
