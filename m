Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVHZVgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVHZVgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHZVgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:36:53 -0400
Received: from lucidpixels.com ([66.45.37.187]:13490 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S965173AbVHZVgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:36:52 -0400
Date: Fri, 26 Aug 2005 17:36:51 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel/Box Freezes Under Kernel 2.6.12.5
Message-ID: <Pine.LNX.4.63.0508261733400.363@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.12.5:
1- 400GB Seagate 8MB cache, 7200RPM, ATA/100 drive.
2- ATA/133 Maxtor (ATA/Promise Controller)

1) Attached 400GB to Seagate 400GB drive.
2) (Not mounted yet)
3) See below

hde: 781422768 sectors (400088 MB) w/8192KiB Cache, CHS=48641/255/63, 
UDMA(100)

4) Partition with fdisk (hde1).
5) mkfs.xfs /dev/hde1

*** KERNEL FREEZE *** (ENTIRE MACHINE LOCKS UP)

Do the SAME EXACT THING on the motherboard (INTEL) controller or an 
ATA/100 Promise Controller, there are NO problems.

Either people with this problem are *not* reporting it or do not know 
where to report the problem to.

This is the second machine I have seen this problem with.

Has anyone looked into this?

Justin.

