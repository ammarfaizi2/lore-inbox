Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTKFWrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 17:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTKFWrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 17:47:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65034 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261188AbTKFWrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 17:47:17 -0500
Date: Thu, 6 Nov 2003 17:36:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <200311061455.41642.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.3.96.1031106172846.16450A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Gene Heskett wrote:

> On Thursday 06 November 2003 14:14, bill davidsen wrote:
> >In article <20031105101207.GI1477@suse.de>, Jens Axboe  
> <axboe@suse.de> wrote:
> >| k3b is probably still going through ide-scsi which you must not.
> >| It would be interesting if you could try without ide-scsi and use
> >| cdrecord manually (maybe someone more knowledgable on k3b can
> >| common on whether they support 2.6 or not). 2.6 will be a lot
> >| faster than 2.4.
> >
> >I'm not sure what you mean by faster, burning runs at device limited
> >speed in CPU time in the  less than 1% range if you remember to
> > enable DMA. The last time I looked DMA didn't work in either kernel
> > if write size was not a multiple of 1k, (or 2k?) has that changed?
> >
> >I'm not sure what you meant by faster, so don't think I'm
> > disagreeing with you.
> 
> As in it actually said it was burning at 12x, and could do a 650 meg 
> iso in a bit over 6 minutes including fixating.  Thats about 3 to 4 
> minutes faster than its ever been.

Okay, more or less as expected, 650MB and 380sec (just over six minutes)
is 10.17x, allowing for OPC and fixating that's about what you would
expect.

Are you saying that a 12x burn using a 2.4 kernel and ide-scsi doesn't
take the same time? Because I see ~1.7MB/s if I use speed=12 with
ide-scsi, and that's as expected (1x = 44100*4/1024 kB/s). Haven't got a
2.6 system with a burner here, but I do at my other site.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

