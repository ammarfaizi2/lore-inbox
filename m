Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUJUQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUJUQYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUJUQYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:24:45 -0400
Received: from math.ut.ee ([193.40.5.125]:48591 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S268839AbUJUQTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:19:34 -0400
Date: Thu, 21 Oct 2004 19:19:31 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
In-Reply-To: <20041021161100.GA14154@suse.de>
Message-ID: <Pine.GSO.4.44.0410211915460.12730-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > ide-cd: cmd 0x28 timed out
> > > > hdc: DMA interrupt recovery
> > > > hdc: lost interrupt
> > > > hdc: status timeout: status=0xd0 { Busy }
> > > > hdc: status timeout: error=0x00
> > > > hdc: DMA disabled
> > > > hdc: drive not ready for command
> > > > hdc: ATAPI reset complete

> > It worked in earlier 2.4 kernels (2.4.18?) with DMA - I don't remember
> > if it had some reliability problems. Since then, it's no dma. We have 3
> > such computers here (Intel D816EEA2 mainboard, this specific Sony CDrom)
> > and they all behave the same.
>
> 2.4.x never used dma for this operation. Does 2.6.9 work if you turn off
> dma first?

I have not tried this operation before. Reading data disks with DMA
worked and that's what I have used. I did read the same disk with
readdisk subcommand on readcd currently, it was successful until the end
of disk (6xx MB - maybe the end of the disk).

Will try it with turning DMA off first.

-- 
Meelis Roos (mroos@linux.ee)

