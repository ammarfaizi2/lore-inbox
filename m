Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUBMBKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUBMBKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:10:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26300 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S266609AbUBMBKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:10:31 -0500
Date: Fri, 13 Feb 2004 10:09:44 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: the first port of uClinux/ARM for 2.6 kernel (armnommu architecture)
To: linux-arm-kernel@lists.arm.linux.org.uk,
       "'uClinux development list'" <uclinux-dev@uclinux.org>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Message-id: <009501c3f1ce$13fc88a0$1327dba8@dmsst.net>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook, Build 10.0.4024
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

 I'm reporting of the first port of new architecture(armnommu) for 2.6
kernel is done.

 I planning the patch against recent kernel version will be announced in
this month, after some test and addition of 1~2 more chips. The current
port include support of only one (Samsung S5C7375 SoC) for test.

 As you know, the official 2.6 linux kernel merged uClinux, but the
ARM(w/o mmu) was not included.

 You'll find more detail on http://www.ucdot.org , soon. Any comment is
welcomed.

PS: I worked on toolchain for linux kernel compile, too. it works for
now, of course.^^  However, there is some toolchain trouble yet for user
program compile, and think there will, too. Is there anyone who're
interested on that work?

<EOT>

CHOI, HYOK-SUNG
Engineer (Linux System Software)
S/W Platform Lab, Digital Media R&D Center
Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com

[compile&run]
main(a){printf(a,34,a="main(a){printf(a,34,a=%c%s%c,34);}",34);}


  

