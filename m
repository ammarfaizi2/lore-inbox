Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTBPB5A>; Sat, 15 Feb 2003 20:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTBPB5A>; Sat, 15 Feb 2003 20:57:00 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:18698 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265578AbTBPB47>; Sat, 15 Feb 2003 20:56:59 -0500
Subject: [PATCH] 2.5.61 correct the spelling of correction and correctly
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 18:58:38 -0700
Message-Id: <1045360720.5611.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This corrects the spelling of correction and correctly.

Steven


diff -ur linux-2.5.61-1.1027-orig/drivers/ide/pci/amd74xx.c linux-2.5.61-1.1027/drivers/ide/pci/amd74xx.c
--- linux-2.5.61-1.1027-orig/drivers/ide/pci/amd74xx.c	Fri Feb 14 20:11:56 2003
+++ linux-2.5.61-1.1027/drivers/ide/pci/amd74xx.c	Sat Feb 15 18:48:54 2003
@@ -311,7 +311,7 @@
 			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
-					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.\n");
+					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.\n");
 					amd_80w |= (1 << (1 - (i >> 4)));
 				}
 			break;
diff -ur linux-2.5.61-1.1027-orig/include/linux/rtc.h linux-2.5.61-1.1027/include/linux/rtc.h
--- linux-2.5.61-1.1027-orig/include/linux/rtc.h	Thu Jan 16 19:21:33 2003
+++ linux-2.5.61-1.1027/include/linux/rtc.h	Sat Feb 15 18:49:38 2003
@@ -57,8 +57,8 @@
 	int pll_value;      /* get/set correction value */
 	int pll_max;        /* max +ve (faster) adjustment value */
 	int pll_min;        /* max -ve (slower) adjustment value */
-	int pll_posmult;    /* factor for +ve corection */
-	int pll_negmult;    /* factor for -ve corection */
+	int pll_posmult;    /* factor for +ve correction */
+	int pll_negmult;    /* factor for -ve correction */
 	long pll_clock;     /* base PLL frequency */
 };
 




