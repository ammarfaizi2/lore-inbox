Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTIJPNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTIJPNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:13:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:42687 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264943AbTIJPNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:13:13 -0400
Date: Wed, 10 Sep 2003 08:12:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Timothy Miller <miller@techsource.com>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030910151238.GC32321@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Timothy Miller <miller@techsource.com>,
	Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <20030903173213.GC5769@work.bitmover.com> <89360000.1062613076@flay> <20030904003633.GA5227@work.bitmover.com> <6130000.1062642088@[10.10.2.4]> <20030904023446.GG5227@work.bitmover.com> <9110000.1062643682@[10.10.2.4]> <20030904030227.GJ5227@work.bitmover.com> <3F5F3D0A.8000700@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5F3D0A.8000700@techsource.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:02:34AM -0400, Timothy Miller wrote:
> Larry McVoy wrote:
> >You don't make that much money, if any, on the high end, the R&D costs
> >dominate.  But you make money because people buy the middle of the road
> >because you have the high end.  If you don't, they feel uneasy that they
> >can't grow with you.  The high end enables the sales of the real money
> >makers.  It's pure marketing, the high end could be imaginary and as
> >long as you convinced the customers you had it you'd be more profitable.
> 
> I think some time in the 90's, Chevy considered discontinuing the 
> Corvette.  Then they realized that that would kill their business. 
> People who would never buy a Corvette buy other GM cars just because the 
> Corvette exists.  Lots of reasons:  It's an icon that people recognize, 
> it makes them feel that other Chevys will share some of the Corvette 
> quality, etc.

Yeah, yeah.  I get that.  What people here are not getting is that if you
are building the low end cars out of the same parts as the high end cars
then you are driving up the cost of your low end cars.  Same thing for
the OS.  The point is to have some answer that lets people go "ohhh,
wow, that's a big fast OS, now, isn't it?" without having screwed up
the low end and/or having made the source base a rats nest.

Dave and friends can protest as much as they want that the kernel works
and it scales (it does work, it doesn't scale by comparison to something
like IRIX) but that's missing the point.  They refused to answer the 
question about listing the locks in the I/O path.  In a uniprocessor
OS any idiot can tell you the locks in the I/O path.  They didn't even
try to list them, they can't do it now.  What's it going to be like 
when the system scales 10x more?

I've been through this.  These guys are kidding themselves and by the
time they wake up there is too much invested in the source base to 
unravel the mess.

What people keep missing, over and over, is that I'm perfectly OK with
the idea of making the system work on a big box.  I've made a proposal
for a way that I see has far less pressure on it to screw up the OS.
You don't have to scale the I/O path when you can throw a kernel at every
device if you want.  The I/O path is free, it's uniprocessor, simple.
Think about it.  We're all trying to have the bragging rights, I do 
enough sales that I understand the importance of those.  It just makes
me sick to think that we could get them far faster and far more easily
than the commercial Unix guys did and than Microsoft will and instead
we're playing by the wrong rules.

Don't like my rules?  Make up some different ones.  But doing the same
old thing is just bloody stupid.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
