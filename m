Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbTICPjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTICPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:39:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:3794 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S263492AbTICPjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:39:07 -0400
Date: Wed, 3 Sep 2003 08:39:01 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903153901.GB5769@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Anton Blanchard <anton@samba.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme> <3F55907B.1030700@cyberone.com.au> <27780000.1062602622@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27780000.1062602622@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:23:44AM -0700, Martin J. Bligh wrote:
> > I think LM advocates aiming single image scalability at or before the knee
> > of the CPU vs performance curve. Say thats 4 way, it means you should get
> > good performance on 8 ways while keeping top performance on 1 and 2 and 4
> > ways. (Sorry if I mis-represent your position).
> 
> Splitting big machines into a cluster is not a solution. However, oddly 
> enough I actually agree with Larry, with one major caveat ... you have to
> make it an SSI cluster (single system image) - that way it's transparent
> to users. 

Err, when did I ever say it wasn't SSI?  If you look at what I said it's
clearly SSI.  Unified process, device, file, and memory namespaces.

I'm pretty sure people were so eager to argue with my lovely personality
that they never bothered to understand the architecture.  It's _always_
been SSI.  I have slides going back at least 4 years that state this:

	http://www.bitmover.com/talks/smp-clusters
	http://www.bitmover.com/talks/cliq

> Numbers would be cool ... particularly if people can refrain from the
> "it's worse, therefore it must be some scalability change that's at fault"
> insta-moron-leap-of-logic.

It's really easy to claim that scalability isn't the problem.  Scaling
changes in general cause very minute differences, it's just that there
are a lot of them.  There is constant pressure to scale further and people
think it's cool.  You can argue you all you want that scaling done right
isn't a problem but nobody has ever managed to do it right.  I know it's
politically incorrect to say this group won't either but there is no 
evidence that they will.

Instead of doggedly following the footsteps down a path that hasn't worked
before, why not do something cool?  The CC stuff is a fun place to work,
it's the last paradigm shift that will ever happen in OS, it's a chance 
for Linux to actually do something new.  I harp all the time that open
source is a copying mechanism and you are playing right into my hands.
Make me wrong.  Do something new.  Don't like this design?  OK, then come
up with a better design.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
