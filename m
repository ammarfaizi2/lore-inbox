Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934450AbWKXGwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934450AbWKXGwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 01:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934451AbWKXGwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 01:52:12 -0500
Received: from brick.kernel.dk ([62.242.22.158]:58895 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S934450AbWKXGwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 01:52:11 -0500
Date: Fri, 24 Nov 2006 07:52:09 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061124065209.GX4999@kernel.dk>
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com> <20061122110740.GA8055@kernel.dk> <200611240052.13719.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611240052.13719.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24 2006, Jesper Juhl wrote:
> > Does the box survive io intensive workloads? 
> 
> It seems to. It does get sluggish as hell when there is lots of disk I/O but
> it seems to be able to survive.  
> I'll try some more, with some IO benchmarks + various other stuff to see 
> if I can get it to die that way.

Just wondering if you have a marginal powersupply, perhaps.

> > Have you tried using net or 
> > serial console to see if it spits out any info before it crashes?
> 
> Lacking a second box at the moment, so that's not an option currently :(

It's likely a requirement to get any further with this issue, I'm
afraid. Nobody can debug this thing blind folded.

-- 
Jens Axboe

