Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVDAGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVDAGRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVDAGRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:17:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11864 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261515AbVDAGRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:17:13 -0500
Date: Fri, 01 Apr 2005 15:15:49 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] the MPU/noMMU support for ARM Linux 2.6.11.6 (-hsc0)
In-reply-to: 
To: uClinux development list <uclinux-dev@uclinux.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
       rmk@arm.linux.org.uk
Message-id: <0IE900JYS84MQI@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcU1BWcNVc0V74LDSaahcUiPaBabRQAAA+EQAF6QSaA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm glad to announce the MPU and noMMU support patch for ARM against
2.6.11.6 at:

http://opensrc.sec.samsung.com/download/linux-2.6.11.6-hsc0.patch.gz

Actually the patch was "armnommu" architecture patch by 2.6.9, but it is
just merged into "arm" architecture, and provides selection option, "MMU"
for linux and "MPU", "NONE" for uclinux. It means that you can choose "MMU"
or even "NONE" for your MMU based arm platform with a few modification (i.e.
virtual addr --> physical addr), if you want to use "singular address space"
which is proven to have performance improvement. (I'd like to provide some
benchmark result on same h/w platform for both cases.)

some addtional MPU support API is pending to support new features like
memory protection for uclinux, but I need more suggestions on that.

You can reach the project at : http://opensrc.sec.samsung.com/

currently officially supported platforms are : s3c24a0, s5c7375, atmel,
espd_s3c510b, P2001, s3c3410, s3cb0x.

Best Regards,
Hyok

---
CHOI, HYOK-SUNG
Engineer (Kernel/System Architecture)
Digital Media R&D Center, Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com
[Linux 2.6 ARM MPU/noMMU Kernel Maintainer] http://opensrc.sec.samsung.com/

