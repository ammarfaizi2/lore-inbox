Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936308AbWLAPVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936308AbWLAPVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936471AbWLAPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:21:38 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:6408 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936308AbWLAPVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:21:38 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] arm sa1100 parenthesis fix
Date: Fri, 1 Dec 2006 16:21:12 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011621.12946.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis stuff.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-arm/arch-sa1100/SA-1101.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.4.34-pre6-a/include/asm-arm/arch-sa1100/SA-1101.h	2001-02-13 23:13:44.000000000 +0100
+++ linux-2.4.34-pre6-b/include/asm-arm/arch-sa1100/SA-1101.h	2006-12-01 12:08:00.000000000 +0100
@@ -98,7 +98,7 @@
 #define SMCR_ColAdrBits( x )		  /* col. addr bits 8..11 */ \
 	(( (x) - 8 ) << FShft (SMCR_DCAC))
 #define SMCR_RowAdrBits( x )		  /* row addr bits 9..12 */\
-	(( (x) - 9 ) << FShft (SMCR_DRAC)
+	(( (x) - 9 ) << FShft (SMCR_DRAC))
 
 #define SNPR_VFBstart	  Fld(12,0)	/* Video frame buffer addr */
 #define SNPR_VFBsize	  Fld(11,12)	/* Video frame buffer size */
@@ -386,7 +386,7 @@
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
