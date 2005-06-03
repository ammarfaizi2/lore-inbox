Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFCOgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFCOgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFCOgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:36:38 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:38122 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261274AbVFCOgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:36:36 -0400
Message-ID: <1117806619.42a0601b371b8@imp5-q.free.fr>
Date: Fri,  3 Jun 2005 15:50:19 +0200
From: THESNIERES Sylvain <tmsec@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [2.6.11.10][Ali15x3] Crash at startup after disks detection in DMA66 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 129.247.247.239
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I used the kernel 2.6.10-gentoo-rc9 with my notebook (Pentium 4-M, no
trademark), it worked fine and I updated to 2.6.11.10 with fbsplash patch, and
now DMA causes the system to crash at boot time. I can't dump any message,
because my screen get flooded with the folowing one:

Free on bad allocation ressource <0000042>-<0000042>

It justs occurs after detection of the hard drive, and only if I activate
idebus=66 or ata0=66 parameters on command line. I have enabled Ali15x3 support
on the kernel and DMA support. The problem disappears if I disable the 66 mode,
but It worked before on the 2.6.10 kernel, so I don't think it is the same
problem as the one related to the last patch I saw for this driver:

[quote]
    [PATCH] ide-disk: Fix LBA8 DMA

    This is from Gentoo's 2.6.11 patchset. A problem was introduced in 2.6.10
    where some users could not enable DMA on their disks (particularly ALi15x3
    users). This was a small mistake with the no_lba48_dma flag.
[/quote]

Thank you for answering.

S.T.
