Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRARIkb>; Thu, 18 Jan 2001 03:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRARIkV>; Thu, 18 Jan 2001 03:40:21 -0500
Received: from wsa-245.sibintek.net ([213.128.193.245]:5131 "EHLO
	mail.ixcelerator.com") by vger.kernel.org with ESMTP
	id <S130417AbRARIkT>; Thu, 18 Jan 2001 03:40:19 -0500
Date: Thu, 18 Jan 2001 11:34:54 +0300
From: "Vladimir V. Klenov" <maple@ixcelerator.com>
To: linux-kernel@vger.kernel.org
Subject: missing closing bracket in arch/arm/mach-sa1100/arch.c
Message-ID: <20010118113454.A1936@ixcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

--- arch/arm/mach-sa1100/arch.c.orig    Thu Jan 18 11:30:49 2001
+++ arch/arm/mach-sa1100/arch.c Thu Jan 18 11:30:57 2001
@@ -235,7 +235,7 @@
 #ifdef CONFIG_SA1100_ITSY
 MACHINE_START(ITSY, "Compaq Itsy")
        BOOT_MEM(0xc0000000, 0x80000000, 0xf8000000)
-       BOOT_PARAMS(0xc0000100
+       BOOT_PARAMS(0xc0000100)
        FIXUP(fixup_sa1100)
        MAPIO(sa1100_map_io)
 MACHINE_END


			SY, Vladimir
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
