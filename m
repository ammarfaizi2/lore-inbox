Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVEGIYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVEGIYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVEGIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:14:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18340 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262778AbVEGILU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:11:20 -0400
Date: Sat, 07 May 2005 17:09:41 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 4/17] ARMNOMMU - nommu/mpu patch for arch/arm/boot/compressed/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GPA1EVNY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3B6x7HGmjhDwRGmhoc1CaBwYKg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [4/17]
 
- nommu/mpu patch for arch/arm/boot/compressed/*

 arch/arm/boot/compressed/Makefile          |   11
 arch/arm/boot/compressed/head-espd_4510b.S |  448
+++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head-p2001.S      |  383 ++++++++++++++++++++++++
 arch/arm/boot/compressed/head-s3c44b0.S    |  372 ++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S            |  199 ++++++++++--
 5 files changed, 1371 insertions(+), 42 deletions(-) 
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-boot.patch
.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

