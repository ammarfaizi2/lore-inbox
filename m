Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWIQLMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWIQLMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWIQLMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 07:12:13 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:1929 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S964938AbWIQLMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 07:12:12 -0400
Date: Fri, 15 Sep 2006 20:17:09 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20060915181709.GA15333@kernel.dk>
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060808190241.GB11829@suse.de> <20060810122853.GS11829@suse.de> <200609031315.04308.mlkernel@mortal-soul.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609031315.04308.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03 2006, Matthias Dahl wrote:
> On Thursday 10 August 2006 14:28, Jens Axboe wrote:
> 
> >> > [...] It would be
> >> > nice if you could gather vmstat 1 info during a problematic period.
> >> > blktrace info could also be very useful:
> >>
> >> - Does disabling preemtion (CONFIG_PREEMPT_NONE=y) help?
> 
> >  http://www.mortal-soul.de/blktrace.log.bz2
> >  http://www.mortal-soul.de/vmstat.log.bz2
> 
> Jens, did you get these? Just wondered because it's been almost a month since. 
> BTW... just a few more observations:
> 
> 1. running an OpenGL app like ET and just having some compiling done in the
>    background or some light disk io gives distorted sound playback as well as
>    very poor OpenGL performance
> 
> 2. switching between console and xorg also results in short sound distortions
>    even though the cpu load is almost zero
> 
> Maybe those and the original problem are somehow related.

Sounds like a hardware issue, someone could be hogging the bus. You
could try and play with the pci latency setting.

-- 
Jens Axboe

