Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVEGIYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVEGIYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVEGIOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:14:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:2467 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262783AbVEGIME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:04 -0400
Date: Sat, 07 May 2005 17:10:25 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 7/17] ARMNOMMU - platform patch for atmel
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GQR1G2NY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3Div9K2sSTppTiabVKcwzr2vAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [7/17]

- platform patch for atmel

 arch/arm/mach-atmel/Kconfig              |   61 +++++++
 arch/arm/mach-atmel/Makefile             |    7
 arch/arm/mach-atmel/Makefile.boot        |    2
 arch/arm/mach-atmel/arch.c               |   56 ++++++
 arch/arm/mach-atmel/head.S               |   83 ++++++++++
 arch/arm/mach-atmel/irq.c                |  215 ++++++++++++++++++++++++++
 arch/arm/mach-atmel/time.c               |  101 ++++++++++++
 include/asm-arm/arch-atmel/at91x40.h     |   57 ++++++
 include/asm-arm/arch-atmel/at91x63.h     |   73 ++++++++
 include/asm-arm/arch-atmel/dma.h         |   26 +++
 include/asm-arm/arch-atmel/entry-macro.S |   39 ++++
 include/asm-arm/arch-atmel/hardware.h    |  255
+++++++++++++++++++++++++++++++
 include/asm-arm/arch-atmel/io.h          |   40 ++++
 include/asm-arm/arch-atmel/irq.h         |   22 ++
 include/asm-arm/arch-atmel/irqs.h        |   65 +++++++
 include/asm-arm/arch-atmel/keyboard.h    |   21 ++
 include/asm-arm/arch-atmel/memory.h      |   30 +++
 include/asm-arm/arch-atmel/param.h       |    6
 include/asm-arm/arch-atmel/sizes.h       |   52 ++++++
 include/asm-arm/arch-atmel/system.h      |   42 +++++
 include/asm-arm/arch-atmel/time.h        |   29 +++
 include/asm-arm/arch-atmel/timex.h       |   10 +
 include/asm-arm/arch-atmel/uncompress.h  |   58 +++++++
 include/asm-arm/arch-atmel/vmalloc.h     |   35 ++++
 24 files changed, 1385 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-atmel.patc
h.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

