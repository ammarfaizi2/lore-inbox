Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVEGIYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVEGIYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVEGIPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:15:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14756 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262777AbVEGILH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:11:07 -0400
Date: Sat, 07 May 2005 17:09:28 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 3/17] ARMNOMMU - nommu/mpu patch for include/asm-arm/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GOY1EINY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3BcYbl1ZtOXsSE2TB0lW7iyX0Q==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [3/17]
 
- nommu/mpu patch for include/asm-arm/*

 include/asm-arm/bugs.h             |    5 +
 include/asm-arm/byteorder.h        |    8 ++
 include/asm-arm/cacheflush-nommu.h |   49 ++++++++++++++++
 include/asm-arm/cacheflush.h       |   30 ++++++++++
 include/asm-arm/cpu-multi32.h      |    5 +
 include/asm-arm/cpu-single.h       |    5 +
 include/asm-arm/domain.h           |    6 ++
 include/asm-arm/flat.h             |   20 ++++++
 include/asm-arm/glue.h             |   24 ++++++++
 include/asm-arm/hardware.h         |   23 +++++++
 include/asm-arm/hardware/dcc.h     |   49 ++++++++++++++++
 include/asm-arm/mach/arch.h        |   15 +++++
 include/asm-arm/memory.h           |   33 +++++++++++
 include/asm-arm/mmu.h              |    8 ++
 include/asm-arm/mmu_context.h      |    6 ++
 include/asm-arm/nommu.h            |   19 ++++++
 include/asm-arm/nommu_context.h    |   46 +++++++++++++++
 include/asm-arm/page-nommu.h       |   54 ++++++++++++++++++
 include/asm-arm/page.h             |    6 ++
 include/asm-arm/pgalloc.h          |    7 ++
 include/asm-arm/pgtable-nommu.h    |  108
+++++++++++++++++++++++++++++++++++++
 include/asm-arm/pgtable.h          |    7 ++
 include/asm-arm/proc-fns.h         |   35 +++++++++++
 include/asm-arm/processor.h        |    8 ++
 include/asm-arm/procinfo.h         |   11 +++
 include/asm-arm/system.h           |    6 ++
 include/asm-arm/tlb.h              |   10 +++
 include/asm-arm/tlbflush.h         |    9 +++
 include/asm-arm/uaccess-nommu.h    |   37 ++++++++++++
 include/asm-arm/uaccess.h          |   10 +++
 30 files changed, 659 insertions(+)

 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-asm.patch.
bz2

---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

