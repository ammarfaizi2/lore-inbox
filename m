Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTEMFcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTEMFcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:32:42 -0400
Received: from [203.124.139.208] ([203.124.139.208]:26087 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S262912AbTEMFcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:32:42 -0400
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "Chandrasekhar" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with LVM
Date: Tue, 13 May 2003 11:29:36 +0530
Message-ID: <NHBBIPBFKBJLCPPIPIBCIEFJCAAA.chandrasekhar.nagaraj@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Experts,
We are not able to use LVM (lvm-1.0.3-9) in kernels 2.4.18-3(RH 7.3) and
2.4.18-14(RH 8.0).We executed the following steps to create a volume group.
pvcreate /dev/sda1 /dev/sda2
vgcreate test_vg /dev/sda1 /dev/sda2
vgscan

After executing a vgscan it gave the following kernel BUG.
kernel BUG at block_dev.c:382!
EIP is at bdput [kernel] 0x1b (2.4.18-14)

The same procedure when executed on kernels 2.4.7-10(Red hat 7.2) and
2.4.9-e.3(Red Hat Advaned Server 2.1) does not give a kernel BUG.

What could be the possible reason and what is the likely solution?

Thanks and Regards
Chandrasekhar

