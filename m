Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284330AbRLGStl>; Fri, 7 Dec 2001 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285399AbRLGSt0>; Fri, 7 Dec 2001 13:49:26 -0500
Received: from bitmover.com ([192.132.92.2]:29329 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284330AbRLGSsb>;
	Fri, 7 Dec 2001 13:48:31 -0500
Date: Fri, 7 Dec 2001 10:48:30 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207104830.N27589@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>,
	Henning Schmiedehausen <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011207102318.J27589@work.bitmover.com> <2699373574.1007721720@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2699373574.1007721720@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Fri, Dec 07, 2001 at 10:42:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 10:42:00AM -0800, Martin J. Bligh wrote:
> >> So would that mean I would need bitkeeper installed in order to change my
> >> password? 
> > 
> > No, that's just one way to solve the problem.  Another way would be to have
> > a master/slave relationship between the replicas sort of like CVS.  In fact,
> > you could use CVS.
> 
> I'm not sure that's any less vomitworthy. 

You're right, it's so much better to manage all machines independently
so that they can get out of sync with each other.

Did you even consider that this is virtually identical to the problem
that a network of workstations or servers has?  Did it occur to you that
people have solved this problem in many different ways?  Or did you just
want to piss into the wind and enjoy the spray?

> Keeping things simple that users and/or sysadmins have to deal with is a 
> Good Thing (tm). I'd have the complexity in the kernel, where complexity 
> is pushed to the kernel developers, thanks.

Yeah, that's what I want, my password file management in the kernel.  
Brilliant.  Why didn't I think of that?

> >> And IIRC, bitkeeper is not free either?
> >
> > (... some slighty twisted concept of free snipped.)
> >
> >  But this is more than a bit off topic...
> 
> No it's not that far off topic, my point is that you're shifting the complexity 
> problems to other areas (eg. system mangement / the application level / 
> filesystems / scheduler load balancing) rather than solving them.

Whoops, you are so right, in order to work on OS scaling I'd better solve
password file management or the OS ideas are meaningless.  Uh huh.  I'll
get right on that, thanks for setting me straight here.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
