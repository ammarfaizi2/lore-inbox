Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759090AbWLAO5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759090AbWLAO5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbWLAO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:57:38 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:59399 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759140AbWLAO5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:57:37 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] video cyberfb remove broken and unused macro
Date: Fri, 1 Dec 2006 15:57:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011557.11897.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes broken and unused macro.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/video/cyberfb.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.4.34-pre6-a/drivers/video/cyberfb.c	2001-11-14 23:52:20.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/video/cyberfb.c	2006-12-01 12:28:11.000000000 +0100
@@ -110,8 +110,6 @@ static void cv64_dump(void);
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
