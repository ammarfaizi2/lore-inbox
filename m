Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759151AbWLAPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151AbWLAPOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759281AbWLAPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:14:46 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:26632 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759151AbWLAPOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:14:45 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] video pm3fb parenthesis fix
Date: Fri, 1 Dec 2006 16:14:18 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011614.18510.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis stuff.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/video/pm3fb.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-2.4.34-pre6-a/drivers/video/pm3fb.h	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/video/pm3fb.h	2006-12-01 12:05:31.000000000 +0100
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
