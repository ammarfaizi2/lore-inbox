Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTICQGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTICQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:04:12 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:25010 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263659AbTICPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:51:32 -0400
Date: Wed, 03 Sep 2003 08:50:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <31190000.1062604245@[10.10.2.4]>
In-Reply-To: <20030903153901.GB5769@work.bitmover.com>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme> <3F55907B.1030700@cyberone.com.au> <27780000.1062602622@[10.10.2.4]> <20030903153901.GB5769@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Err, when did I ever say it wasn't SSI?  If you look at what I said it's
> clearly SSI.  Unified process, device, file, and memory namespaces.

I think it was the bit when you suggested using bitkeeper to sync multiple
/etc/passwd files when I really switched off ... perhaps you were just
joking ;-) Perhaps we just had a massive communication disconnect.
 
> I'm pretty sure people were so eager to argue with my lovely personality
> that they never bothered to understand the architecture.  It's _always_
> been SSI.  I have slides going back at least 4 years that state this:
> 
> 	http://www.bitmover.com/talks/smp-clusters
> 	http://www.bitmover.com/talks/cliq

I can go back and re-read them, if I misread them last time than I apologise.
I've also shifted perspectives on SSI clusters somewhat over the last year. 
Yes, if it's SSI, I'd agree for the most part ... once it's implemented ;-)

I'd rather start with everything separate (one OS instance per node), and
bind things back together, than split everything up. However, I'm really
not sure how feasible it is until we actually have something that works.

I have a rough plan of how to go about it mapped out, in small steps that
might be useful by themselves. It's a lot of fairly complex hard work ;-)

>> Numbers would be cool ... particularly if people can refrain from the
>> "it's worse, therefore it must be some scalability change that's at fault"
>> insta-moron-leap-of-logic.
> 
> It's really easy to claim that scalability isn't the problem.  Scaling
> changes in general cause very minute differences, it's just that there
> are a lot of them.  There is constant pressure to scale further and people
> think it's cool.  You can argue you all you want that scaling done right
> isn't a problem but nobody has ever managed to do it right.  I know it's
> politically incorrect to say this group won't either but there is no 
> evidence that they will.

Let's not go into that one again, we've both dragged that over the coals
already. Time to agree to disagree. All the significant degredations I
looked at that people screamed were scalability changes turned out to
be something else completely. 
 
> Instead of doggedly following the footsteps down a path that hasn't worked
> before, why not do something cool?  The CC stuff is a fun place to work,
> it's the last paradigm shift that will ever happen in OS, it's a chance 
> for Linux to actually do something new.  I harp all the time that open
> source is a copying mechanism and you are playing right into my hands.
> Make me wrong.  Do something new.  Don't like this design?  OK, then come
> up with a better design.

I'm cool with doing SSI clusters over NUMA on a per-node basis. But it's
still vapourware ... yes, I'd love to work on that full time to try and
change that if I can get funding to do so.

M.

