Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUIXOSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUIXOSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268779AbUIXOQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:16:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52146 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268781AbUIXOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:16:12 -0400
Date: Fri, 24 Sep 2004 16:07:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Thomas Habets <thomas@habets.pp.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040924140710.GB467@openzaurus.ucw.cz>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923234520.GA7303@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How about a sysctl that does "for the love of kbaek, don't ever kill these 
> > processes when OOM. If nothing else can be killed, I'd rather you panic"?

You should not be able to force kernel panic. But it might make sense to say
"if you want to kill xlock, kill all processes with same uid, too". 

> An aircraft company discovered that it was cheaper to fly its planes
> with less fuel on board. The planes would be lighter and use less fuel
> and money was saved. On rare occasions however the amount of fuel was
> insufficient, and the plane would crash. This problem was solved by
> the engineers of the company by the development of a special OOF
> (out-of-fuel) mechanism. In emergency cases a passenger was selected
> and thrown out of the plane. (When necessary, the procedure was
> repeated.)  A large body of theory was developed and many publications
> were devoted to the problem of properly selecting the victim to be
> ejected.  Should the victim be chosen at random? Or should one choose
> the heaviest person? Or the oldest? Should passengers pay in order not
> to be ejected, so that the victim would be the poorest on board? And
> if for example the heaviest person was chosen, should there be a
> special exception in case that was the pilot? Should first class
> passengers be exempted?  Now that the OOF mechanism existed, it would
> be activated every now and then, and eject passengers even when there
> was no fuel shortage. The engineers are still studying precisely how
> this malfunction is caused.

:-))))

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

