Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUHaGuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUHaGuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHaGuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:50:16 -0400
Received: from mail.wayne-europe.com ([217.237.173.114]:35590 "EHLO
	wayne-europe.com") by vger.kernel.org with ESMTP id S266878AbUHaGuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:50:11 -0400
Message-Id: <04Aug31.085934cest.332169@gateway.wayne-europe.com>
From: Michael Thonke <MThonke@wayne-europe.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ReiserFS v3.6 fails to mount root partiton not usable with 2.6.9-
	rc1-mm1
Date: Tue, 31 Aug 2004 08:50:53 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to boot my root partition (Softwareraid Stripeset) 
with 2.6.9-rc1-mm1 kernel but on fsck.reiserfs
the system stops working and compain about a unresolveable filesystem error
which can't be corrected. I tried to do it manually but no success either.
On start the dmesg output is nearly the same as the one from my old kernel.
No errors while md0 and md1 initialized also the ReiserFS Superblock was
found.
So I went back to my 2.6.8.1 kernel and everything works perfectly.
Does someone get the same error while using ReiserFS v3.6 with
2.6.9-rc1-mm1?

Please CC me while I'm not registred to the mailing list

Thanks in advance
Michael
