Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286385AbRL0RnI>; Thu, 27 Dec 2001 12:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbRL0Rm6>; Thu, 27 Dec 2001 12:42:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2835 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286385AbRL0Rml>; Thu, 27 Dec 2001 12:42:41 -0500
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
To: axboe@suse.de (Jens Axboe)
Date: Thu, 27 Dec 2001 17:50:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andre@linux-ide.org (Andre Hedrick),
        stodden@in.tum.de (Daniel Stodden), linux-kernel@vger.kernel.org
In-Reply-To: <20011227175105.E1730@suse.de> from "Jens Axboe" at Dec 27, 2001 05:51:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JefL-0006GO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've written a block driver that handles (or wants to) bad block
> remapping too, which just made me even more sure that this is definitely
> a hw issue.

And what about when the hardware doesn't handle it ? We have fine
demonstrations that in some cases it does a lousy job, or just plain doesn't
cope. With the current price/reliability for IDE disks personally I'll use
raid1 but it should still be possible to do software remapping either block
level or in some cases fs level.
