Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUHIIkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUHIIkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUHIIkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:40:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26551 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266349AbUHIIkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:40:09 -0400
Date: Mon, 9 Aug 2004 10:39:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040809083929.GQ10418@suse.de>
References: <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de> <1091739966.8418.38.camel@localhost.localdomain> <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de> <1091794470.16306.11.camel@localhost.localdomain> <20040806143258.GB23263@suse.de> <ufa4qnfzloz.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ufa4qnfzloz.fsf@epithumia.math.uh.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Jason L Tibbitts III wrote:
> >>>>> "JA" == Jens Axboe <axboe@suse.de> writes:
> 
> JA> Like when dvd readers became common, you can't just require people
> JA> to update their kernel because a few new commands are needed to
> JA> drive them from user space.
> 
> Perhaps I'm being completely dense, but why would the filtering tables
> have to be compiled into the kernel?  Why not load them from user
> space via a mechanism requiring CAP_SYS_RAWIO?
> 
> How many commands are we talking about here?  Is the mechanism
> workable by a simple bitmask, or is something more complex like a
> state machine required?

Could be done, it's quite some work though. The complexity isn't as much
due to new commands being added (that doesn't happen very often), that's
only problematic from the policy pov. The problem is defining the
tables, it's definitely not trivial. And I still claim not very doable.

-- 
Jens Axboe

