Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRGJTvB>; Tue, 10 Jul 2001 15:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbRGJTuw>; Tue, 10 Jul 2001 15:50:52 -0400
Received: from [32.97.182.101] ([32.97.182.101]:676 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265620AbRGJTue>;
	Tue, 10 Jul 2001 15:50:34 -0400
Date: Tue, 10 Jul 2001 12:49:03 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010710124903.H6013@us.ibm.com>
In-Reply-To: <20010709123936.E6013@us.ibm.com> <20010709214453.U16505@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010709214453.U16505@suse.de>; from axboe@suse.de on Mon, Jul 09, 2001 at 09:44:53PM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Mon, Jul 09 2001, Jonathan Lahr wrote:
> > 
> > I have heard that a patch to reduce io_request_lock contention by
> > breaking it into per queue locks was released in the past.  Does 
> > anyone know where I could find this patch if it exists?
> 
> I had a patch about a year ago that did it safely for the block layer
> and IDE at least, and also for selected SCSI hba's. Some of the latter
> variety are pretty hard and/or tedious to fixup, Eric Y has done some
> work automating this process almost completely. Until that is done, the
> general patch has no chance of being integrated.

I am investigating reducing io_request_lock contention in the shorter term
if possible with smaller incremental modifications.  So I'm first trying to 
discover any previous work that might have been done toward this purpose.

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

