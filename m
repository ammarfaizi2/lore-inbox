Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVC3GdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVC3GdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVC3GdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:33:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:14632 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261756AbVC3GdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:33:11 -0500
Date: Wed, 30 Mar 2005 15:31:48 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] the nommu support for ARM linux 2.6.10
To: linux-kernel@vger.kernel.org
Message-id: <0IE500K8WJJ7E8@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcUwV7i2VXLKJ/ckQjSLot1EE1hS4gElok7gAAD0MNA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated MPU and noMMU support patch for ARM against linux 2.6.10 kernel
is available at :

http://opensrc.sec.samsung.com/download/linux-2.6.10-hsc1.patch.gz

You can select the memory management type "MPU" or "NONE" in the arm kernel
configuration menu, which was traditionally known as "armnommu" or
uClinux/ARM by 2.6.9. (sure, you can choose "MMU" for vanila Linux :-)

It's a different way from other uclinux arch. (i.e. m68knommu), which
enables simultaneous support to use "singular address space" support even
for MMU platforms.
You can choose "MMU" or "NONE" for your mmu based arm platform with a few
modification. i.e. virtual address --> physical address conversion.

the 2.6.11.6-hsc0 patch will be available in this week, and some benchmark
will be provided for both cases on a same h/w platform.
and addtional MPU support API is pending for some services like memory
protection, even for uClinux.

any suggesstions welcomed.

You can reach the project home at : http://opensrc.sec.samsung.com/

currently officially supported platforms are : s3c24a0, s5c7375, atmel,
espd_s3c510b, P2001, s3c3410, s3cb0x.
thanks for contribution : Tobias Lorenz and Jiun-Shian Ho

Regards,
Hyok

---
CHOI, HYOK-SUNG
Engineer (Kernel/System Architecture)
Digital Media R&D Center, Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com
[Linux 2.6 ARM MPU/noMMU Kernel Maintainer] http://opensrc.sec.samsung.com/

