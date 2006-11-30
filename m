Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759199AbWK3JKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759199AbWK3JKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759200AbWK3JKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:10:37 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:24069 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759199AbWK3JKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:10:35 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] arm: arch-sa1100 add missing brackets
Date: Thu, 30 Nov 2006 10:10:05 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301010.05911.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing brackets.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-arm/arch-sa1100/SA-1101.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-arm/arch-sa1100/SA-1101.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-arm/arch-sa1100/SA-1101.h	2006-11-30 01:09:24.000000000 +0100
@@ -106,7 +106,7 @@
 #define SMCR_ColAdrBits( x )		  /* col. addr bits 8..11 */ \
 	(( (x) - 8 ) << FShft (SMCR_DCAC))
 #define SMCR_RowAdrBits( x )		  /* row addr bits 9..12 */\
-	(( (x) - 9 ) << FShft (SMCR_DRAC)
+	(( (x) - 9 ) << FShft (SMCR_DRAC))
 
 #define SNPR_VFBstart	  Fld(12,0)	/* Video frame buffer addr */
 #define SNPR_VFBsize	  Fld(11,12)	/* Video frame buffer size */
@@ -394,7 +394,7 @@
 #define VgaStatus      (*((volatile Word *) SA1101_p2v (_VgaStatus)))
 #define VgaInterruptMask (*((volatile Word *) SA1101_p2v (_VgaInterruptMask)))
 #define VgaPalette     (*((volatile Word *) SA1101_p2v (_VgaPalette)))
-#define DacControl     (*((volatile Word *) SA1101_p2v (_DacControl))
+#define DacControl     (*((volatile Word *) SA1101_p2v (_DacControl)))
 #define VgaTest        (*((volatile Word *) SA1101_p2v (_VgaTest)))
 
 #define VideoControl_VgaEn    0x00000000


-- 
Regards,

	Mariusz Kozlowski
