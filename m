Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313491AbSDLKRF>; Fri, 12 Apr 2002 06:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313507AbSDLKRE>; Fri, 12 Apr 2002 06:17:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29459 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313491AbSDLKRD>;
	Fri, 12 Apr 2002 06:17:03 -0400
Date: Fri, 12 Apr 2002 12:16:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
Message-ID: <20020412101655.GB5285@suse.de>
In-Reply-To: <20020412084150.GE824@suse.de> <Pine.LNX.4.10.10204120154480.489-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12 2002, Andre Hedrick wrote:
> On Fri, 12 Apr 2002, Jens Axboe wrote:
> 
> > On Fri, Apr 12 2002, Petr Vandrovec wrote:
> > > I believe that there must be some reason for doing that... And 
> > > do not ask me why it worked in 2.4.x, as it cleared io_32bit
> > > in task_out_intr too.
> > 
> > Because 2.4 doesn't use that path for fs requests. And be glad that it
> > doesn't otherwise _everybody_ would have much worse problems than you
> > are currently seeing.
> 
> Maybe if everyone ever bothered to look at the code base and not assume
> they know everything ... and enjoying feable attempts to cast me as a
> fool.  Better yet maybe understand the hardware ...

I didn't talk about the 32bit issue at all (as you can read from my mail
above), I simply said why it worked in 2.4 -- because that data path is
never hit for a file system request.

So maybe if you ever bothered to read the emails. Or better yet, not
assume you know everything.

-- 
Jens Axboe

