Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRKOJ4I>; Thu, 15 Nov 2001 04:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKOJz7>; Thu, 15 Nov 2001 04:55:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16395 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280805AbRKOJzl>; Thu, 15 Nov 2001 04:55:41 -0500
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Thu, 15 Nov 2001 10:01:56 +0000 (GMT)
Cc: alastair.stevens@mrc-bsu.cam.ac.uk (Alastair Stevens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BF31C42.469BF2B2@randomlogic.com> from "Paul G. Allen" at Nov 14, 2001 05:37:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164JLI-0007m8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only problem I still have is IDE. I can not run the IDE drive using DMA or the system will hang HARD, usually with the drive access light on. Even with DMA
> disabled it might hang under high IDE usage. I will replace the IDE drive with a SCSI drive soon as the SCSI interface works perfectly and very fast. Early MP
> chipsets had AGP and DMA hardware bugs, but according to AMD errata, the revision in my MoBo should not have these bugs (that doesn't mean it doesn't have them
> though).

The earlier MP chipsets die if you have IDE prefetching enabled (see the
errata doc). I'd be suprised if a BIOS had left that on.
