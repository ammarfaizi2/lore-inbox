Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTBPBim>; Sat, 15 Feb 2003 20:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTBPBim>; Sat, 15 Feb 2003 20:38:42 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:12293 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265196AbTBPBil>; Sat, 15 Feb 2003 20:38:41 -0500
Subject: [PATCH] 2.5.61 fix different spellings of different and differences
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 18:40:20 -0700
Message-Id: <1045359622.5965.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some different spellings.

Steven


diff -ur linux-2.5.61-1.1027-orig/arch/cris/drivers/eeprom.c linux-2.5.61-1.1027/arch/cris/drivers/eeprom.c
--- linux-2.5.61-1.1027-orig/arch/cris/drivers/eeprom.c	Thu Jan 16 19:22:02 2003
+++ linux-2.5.61-1.1027/arch/cris/drivers/eeprom.c	Sat Feb 15 18:31:54 2003
@@ -207,7 +207,7 @@
      * it will mirror the address space:
      * 1. We read two locations (that are mirrored), 
      *    if the content differs * it's a 16kB EEPROM.
-     * 2. if it doesn't differ - write diferent value to one of the locations,
+     * 2. if it doesn't differ - write different value to one of the locations,
      *    check the other - if content still is the same it's a 2k EEPROM,
      *    restore original data.
      */
diff -ur linux-2.5.61-1.1027-orig/include/asm-m68knommu/mcfne.h linux-2.5.61-1.1027/include/asm-m68knommu/mcfne.h
--- linux-2.5.61-1.1027-orig/include/asm-m68knommu/mcfne.h	Thu Jan 16 19:22:44 2003
+++ linux-2.5.61-1.1027/include/asm-m68knommu/mcfne.h	Sat Feb 15 18:32:39 2003
@@ -261,7 +261,7 @@
 
 /*
  *	Lastly the interrupt set up code...
- *	Minor diferences between the different board types.
+ *	Minor differences between the different board types.
  */
 
 #if defined(CONFIG_M5206) && defined(CONFIG_ARNEWSH)


