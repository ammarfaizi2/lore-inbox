Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269476AbTCDOMX>; Tue, 4 Mar 2003 09:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269475AbTCDOMX>; Tue, 4 Mar 2003 09:12:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S269474AbTCDOMS>;
	Tue, 4 Mar 2003 09:12:18 -0500
Date: Tue, 4 Mar 2003 15:20:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: David Anderson <david-anderson2003@mail.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: I/O Request [Elevator; Clustering; Scatter-Gather]
Message-ID: <20030304142041.GA660@suse.de>
References: <20030304133201.18619.qmail@mail.com> <20030304135000.GA29990@suse.de> <20030304141948.264C63BF9D@mx01.nexgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304141948.264C63BF9D@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04 2003, Daniel Phillips wrote:
> On Tuesday 04 March 2003 14:50, Jens Axboe wrote:
> > > Do Clustering of request and scatter-gather mean the same ?? Confused
> > > to the core... Kindly help me ...
> >
> > No, the elevator clustering refers to clustering request that are
> > contigious on disk. Scatter-gather may cluster sg entries that are
> > contigious in memory.
> 
> Hi Jens,
> 
> I think you meant to write *non*contiguous in memory (but contiguous on the 
> device).

No I didn't. Well actually both may happen, depending on your hardware.
What I wrote covers basic x86 hardware.

-- 
Jens Axboe

