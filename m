Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbSIZGJQ>; Thu, 26 Sep 2002 02:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262115AbSIZGJP>; Thu, 26 Sep 2002 02:09:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6846 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262110AbSIZGJO>;
	Thu, 26 Sep 2002 02:09:14 -0400
Date: Thu, 26 Sep 2002 08:14:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020926061419.GA12862@suse.de>
References: <20020925232736.A19209@shookay.newview.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925232736.A19209@shookay.newview.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25 2002, Mathieu Chouquet-Stringer wrote:
> 	  Hello!
> 
> I've upgraded a while to 2.4.19 and my box has been happy for the last 52
> days (it's a dual PIII). Tonight while going through my logs, I've found
> these:
> 
> Sep 25 22:18:41 bigip kernel: Warning - running *really* short on DMA buffers
> Sep 25 22:18:47 bigip last message repeated 55 times
> Sep 25 22:19:41 bigip last message repeated 71 times

This is fixed in 2.4.20-pre

> Oh BTW, just one thing, I wanted to give the throughput of the ide drived
> but it failed:
> Sep 25 23:18:32 bigip kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Sep 25 23:18:32 bigip kernel: hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=102882, sector=102784

Yep, looks like the end of the road for that drive.

-- 
Jens Axboe

