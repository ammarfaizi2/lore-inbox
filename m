Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVEHDOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVEHDOG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVEHDOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:14:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:5261 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262794AbVEHDOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:14:01 -0400
Date: Sun, 08 May 2005 12:12:21 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 7/17][REFINED] ARMNOMMU - platform patch for atmel
In-reply-to: <200505071623.13143.adobriyan@mail.ru>
To: "'Alexey Dobriyan'" <adobriyan@mail.ru>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Cc: "'Greg Ungerer'" <gerg@snapgear.com>
Message-id: <0IG500D0HIBBF1@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS/wL5e9Qo6JKDSAKFBnRl/69sDgAenKjg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the refined atmel patch of nommu/mpu patch set against
2.6.12-rc3-mm3 [7/17]
which accepted all the Alexey Dobriyan's comments.

- platform patch for atmel

 arch/arm/mach-atmel/Kconfig              |   61 +++++++
 arch/arm/mach-atmel/Makefile             |    1
 arch/arm/mach-atmel/Makefile.boot        |    2
 arch/arm/mach-atmel/arch.c               |   37 ++++
 arch/arm/mach-atmel/head.S               |   83 ++++++++++
 arch/arm/mach-atmel/irq.c                |  212 +++++++++++++++++++++++++
 arch/arm/mach-atmel/time.c               |  100 ++++++++++++
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
 24 files changed, 1356 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-atmel2.pat
ch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

