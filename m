Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWHJM1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWHJM1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWHJM1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:27:36 -0400
Received: from brick.kernel.dk ([62.242.22.158]:1866 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161215AbWHJM1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:27:35 -0400
Date: Thu, 10 Aug 2006 14:28:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20060810122853.GS11829@suse.de>
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608061554.42992.mlkernel@mortal-soul.de> <20060807134841.GC10444@suse.de> <200608081944.12630.mlkernel@mortal-soul.de> <20060808190241.GB11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808190241.GB11829@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2006, Jens Axboe wrote:
> On Tue, Aug 08 2006, Matthias Dahl wrote:
> > > Can you see if this makes any difference whatsoever?
> > 
> > Sorry but no change for the better with this patch.
> > 
> > Are there any more informations I can provide to help?
> 
> Ok, it was worth a shot. I got another report that the patch fixes this
> behaviour, so maybe we are dealing with two seperate issues. It would be
> nice if you could gather vmstat 1 info during a problematic period.
> blktrace info could also be very useful:
> 
> http://brick.kernel.dk/snaps/blktrace-git-20060807122505.tar.gz

Some more things to try/questions:

- Did 2.6.16 work well for you?

- Does disabling preemtion (CONFIG_PREEMPT_NONE=y) help?

-- 
Jens Axboe

