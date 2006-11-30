Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933542AbWK3JmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933542AbWK3JmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933622AbWK3JmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:42:14 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:6930 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S933542AbWK3JmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:42:13 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: mchehab@infradead.org
Subject: [PATCH] video: pm3fb macros fix
Date: Thu, 30 Nov 2006 10:41:44 +0100
User-Agent: KMail/1.9.5
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301041.44239.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes some macros.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/video/pm3fb.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-2.6.19-rc6-mm2-a/include/video/pm3fb.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/video/pm3fb.h	2006-11-30 01:07:26.000000000 +0100
@@ -607,16 +607,16 @@
 #define PM3FBDestReadModeOr					0xac98
 	#define PM3FBDestReadMode_ReadDisable			0<<0
 	#define PM3FBDestReadMode_ReadEnable			1<<0
-	#define PM3FBDestReadMode_StripePitch(sp)	(((sp)&0x7)<<2
-	#define PM3FBDestReadMode_StripeHeight(sh)	(((sh)&0x7)<<7
+	#define PM3FBDestReadMode_StripePitch(sp)	(((sp)&0x7)<<2)
+	#define PM3FBDestReadMode_StripeHeight(sh)	(((sh)&0x7)<<7)
 	#define PM3FBDestReadMode_Enable0			1<<8
 	#define PM3FBDestReadMode_Enable1			1<<9
 	#define PM3FBDestReadMode_Enable2			1<<10
 	#define PM3FBDestReadMode_Enable3			1<<11
-	#define PM3FBDestReadMode_Layout0(l)		(((l)&0x3)<<12
-	#define PM3FBDestReadMode_Layout1(l)		(((l)&0x3)<<14
-	#define PM3FBDestReadMode_Layout2(l)		(((l)&0x3)<<16
-	#define PM3FBDestReadMode_Layout3(l)		(((l)&0x3)<<18
+	#define PM3FBDestReadMode_Layout0(l)		(((l)&0x3)<<12)
+	#define PM3FBDestReadMode_Layout1(l)		(((l)&0x3)<<14)
+	#define PM3FBDestReadMode_Layout2(l)		(((l)&0x3)<<16)
+	#define PM3FBDestReadMode_Layout3(l)		(((l)&0x3)<<18)
 	#define PM3FBDestReadMode_Origin0			1<<20
 	#define PM3FBDestReadMode_Origin1			1<<21
 	#define PM3FBDestReadMode_Origin2			1<<22
@@ -640,16 +640,16 @@
 #define PM3FBSourceReadModeOr					0xaca8
 	#define PM3FBSourceReadMode_ReadDisable			(0<<0)
 	#define PM3FBSourceReadMode_ReadEnable			(1<<0)
-	#define PM3FBSourceReadMode_StripePitch(sp)	(((sp)&0x7)<<2
-	#define PM3FBSourceReadMode_StripeHeight(sh)	(((sh)&0x7)<<7
-	#define PM3FBSourceReadMode_Layout(l)		(((l)&0x3)<<8
+	#define PM3FBSourceReadMode_StripePitch(sp)	(((sp)&0x7)<<2)
+	#define PM3FBSourceReadMode_StripeHeight(sh)	(((sh)&0x7)<<7)
+	#define PM3FBSourceReadMode_Layout(l)		(((l)&0x3)<<8)
 	#define PM3FBSourceReadMode_Origin			1<<10
 	#define PM3FBSourceReadMode_Blocking			1<<11
 	#define PM3FBSourceReadMode_UserTexelCoord		1<<13
 	#define PM3FBSourceReadMode_WrapXEnable			1<<14
 	#define PM3FBSourceReadMode_WrapYEnable			1<<15
-	#define PM3FBSourceReadMode_WrapX(w)		(((w)&0xf)<<16
-	#define PM3FBSourceReadMode_WrapY(w)		(((w)&0xf)<<20
+	#define PM3FBSourceReadMode_WrapX(w)		(((w)&0xf)<<16)
+	#define PM3FBSourceReadMode_WrapY(w)		(((w)&0xf)<<20)
 	#define PM3FBSourceReadMode_ExternalSourceData		1<<24
 #define PM3FBWriteBufferAddr0                                   0xb000
 #define PM3FBWriteBufferAddr1                                   0xb008
@@ -942,7 +942,7 @@
 #define PM3Window						0x8980
 	#define PM3Window_ForceLBUpdate				1<<3
 	#define PM3Window_LBUpdateSource			1<<4
-	#define PM3Window_FrameCount(c)				(((c)&0xff)<<9
+	#define PM3Window_FrameCount(c)				(((c)&0xff)<<9)
 	#define PM3Window_StencilFCP				1<<17
 	#define PM3Window_DepthFCP				1<<18
 	#define PM3Window_OverrideWriteFiltering		1<<19


-- 
Regards,

	Mariusz Kozlowski
