Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRJYRcr>; Thu, 25 Oct 2001 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYRck>; Thu, 25 Oct 2001 13:32:40 -0400
Received: from 31.ppp1-3.ski.worldonline.dk ([212.54.90.31]:7809 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S275278AbRJYRcX>; Thu, 25 Oct 2001 13:32:23 -0400
Date: Thu, 25 Oct 2001 19:32:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Christian Hammers <ch@westend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025193248.J4795@suse.de>
In-Reply-To: <20011025120701.C6557@westend.com> <20011025131107.C4795@suse.de> <20011025192351.A9823@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011025192351.A9823@westend.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25 2001, Christian Hammers wrote:
> Hello
> 
> On Thu, Oct 25, 2001 at 01:11:07PM +0200, Jens Axboe wrote:
> > > 2.4.13 was the easiest one to reproduce: when starting the tape backup
> > > to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
> > > (Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
> > > two PIII and 2GB of RAM it crashed immediately with the error attached
> > > below. The machine was under "stresstest-simulation" load at this time.
> 
> > Could you try this patch and see if it fixes the pci.h BUG at least?
> This patch did not prevent the crash. Again immediately after rewinding the
> tape when it began to write. I'll try now the 2.4.12-ac6... and it works.

Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
look.

-- 
Jens Axboe

