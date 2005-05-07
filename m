Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVEGIUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVEGIUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVEGIQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:16:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49828 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262786AbVEGIMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:55 -0400
Date: Sat, 07 May 2005 17:11:15 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 13/17] ARMNOMMU - platform patch for s3c44b0x
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400CP91HGSY@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3FaUwGqPsgOCRqieLSq6UoQR7g==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [13/17]
 
- platform patch for s3c44b0x
 
 arch/arm/mach-s3c44b0x/Kconfig              |   45 +
 arch/arm/mach-s3c44b0x/Makefile             |    8
 arch/arm/mach-s3c44b0x/Makefile.boot        |    2
 arch/arm/mach-s3c44b0x/arch.c               |  107 ++++
 arch/arm/mach-s3c44b0x/cache.S              |   35 +
 arch/arm/mach-s3c44b0x/dma.c                |   22
 arch/arm/mach-s3c44b0x/driver/Kconfig       |   23
 arch/arm/mach-s3c44b0x/driver/Makefile      |   10
 arch/arm/mach-s3c44b0x/driver/console.c     |   41 +
 arch/arm/mach-s3c44b0x/driver/led.c         |   28 +
 arch/arm/mach-s3c44b0x/driver/rtl8019.c     |  419 ++++++++++++++++
 arch/arm/mach-s3c44b0x/driver/rtl8019.h     |   55 ++
 arch/arm/mach-s3c44b0x/head.S               |   74 ++
 arch/arm/mach-s3c44b0x/irq.c                |  143 +++++
 arch/arm/mach-s3c44b0x/mm.c                 |   18
 arch/arm/mach-s3c44b0x/time.c               |  104 ++++
 include/asm-arm/arch-s3c44b0x/dma.h         |   20
 include/asm-arm/arch-s3c44b0x/entry-macro.S |   31 +
 include/asm-arm/arch-s3c44b0x/hardware.h    |   35 +
 include/asm-arm/arch-s3c44b0x/io.h          |   63 ++
 include/asm-arm/arch-s3c44b0x/irq.h         |   20
 include/asm-arm/arch-s3c44b0x/irqs.h        |   37 +
 include/asm-arm/arch-s3c44b0x/keyboard.h    |   16
 include/asm-arm/arch-s3c44b0x/memory.h      |   24
 include/asm-arm/arch-s3c44b0x/param.h       |    6
 include/asm-arm/arch-s3c44b0x/s3c44b0x.h    |  704
++++++++++++++++++++++++++++
 include/asm-arm/arch-s3c44b0x/sizes.h       |   52 ++
 include/asm-arm/arch-s3c44b0x/system.h      |   25
 include/asm-arm/arch-s3c44b0x/time.h        |    7
 include/asm-arm/arch-s3c44b0x/timex.h       |   10
 include/asm-arm/arch-s3c44b0x/uncompress.c  |   23
 include/asm-arm/arch-s3c44b0x/uncompress.h  |   51 ++
 include/asm-arm/arch-s3c44b0x/vmalloc.h     |   18
 33 files changed, 2276 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-s3c44b0x.p
atch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

