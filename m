Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312949AbSDKU6z>; Thu, 11 Apr 2002 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSDKU6y>; Thu, 11 Apr 2002 16:58:54 -0400
Received: from air-2.osdl.org ([65.201.151.6]:26756 "EHLO
	wookie-laptop.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S312949AbSDKU6x>; Thu, 11 Apr 2002 16:58:53 -0400
Subject: Re: Kernel developer attitudes, a problem to watch for.
From: "Timothy D. Witham" <wookie@osdl.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204101540261.29888-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 11 Apr 2002 13:55:58 -0700
Message-Id: <1018558558.5616.38.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On items c and e below.  These are two of the items that
we (OSDL) are addressing.  

 While we won't ever produce a formal design document for
Linux we are working toward two documents that will address
a "more formal" design approach for two uses of Linux.  
These are the carrier grade and data center working groups.
One of the goals of these groups is to produce a high level
roadmap of features and functionality to address these usage
models.   The goal of these documents is to get together
the folks who have an interest in Linux addressing these
market segments and to discover what is missing, what is 
already being done (or already done) and to agree to work on
filling the holes using the current process. But just as
important to the corporate user or commercial ISV to come
up with a time line of when we think the various features
will be ready for use. (Note, this might not be integrated
into the base kernel but that is the goal for every thing
that makes sense to integrate.)

On the formal quality assurance.  I think that is
a product issue and not a kernel development issue.  After
saying that we are trying to automate the testing of
development kernels for both performance and "correctness".
This is using a tool called the Scalable Test Platform (STP)
www.osdl.org/STP.  The theory is that early feedback on
a patch or kernel version is better than waiting until
the folks who do the distributions fix the problems in
their own product quality assurance test cycle. (And have
6 different fixes in 6 different distributions.)

Tim

On Wed, 2002-04-10 at 15:42, David Lang wrote:
> My post was intended to make people realize how ti fit into the existing
> structure, I am not saying that the structure is fundmentally broken and
> needs to be scrapped.
> 
> the fundamental existing process has been far more sucessful then the more
> formal procedures that are allocated, people just need to realize what is
> going on and not expect things to happen that won't.
> 
> David Lang
> 
> 
>  On Wed, 10 Apr 2002, M. Edward (Ed) Borasky wrote:
> 
> > Date: Wed, 10 Apr 2002 15:02:46 -0700 (PDT)
> > From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
> > To: David Lang <david.lang@digitalinsight.com>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: Kernel developer attitudes, a problem to watch for.
> >
> > On Wed, 10 Apr 2002, David Lang wrote:
> >
> > [soapbox snipped]
> >
> > In the absence of
> >
> > a. A formal software development process,
> >
> > b. Formal requirements documents,
> >
> > c. A high-level formal design document,
> >
> > d. Marketing and sales,
> >
> > e. A formal Quality Assurance, Security Assurance and Performance
> > Assurance effort,
> >
> > f. A corporate structure,
> >
> > etc. ...
> >
> > I don't think it's reasonable to expect people to behave in a different
> > manner from the way they currently behave. I've heard this described as
> > a brutal meritocracy, and organizations that need any of the above to
> > meet their objectives are free to implement them at their own cost and
> > to their own (and presumably their customers') benefit.
> >
> > That said, I think Linux could benefit greatly from some of the above,
> > in particular c. and e. And the recent debate over printk vs. event logs
> > would be a non-issue if we had b. and d. -- we'd have both because one
> > is wonderful for rapid debugging and the other is wonderful for system
> > administration.
> > --
> > M. Edward Borasky
> > znmeb@borasky-research.net
> >
> > The COUGAR Project
> > http://www.borasky-research.com/Cougar.htm
> >
> > If God had meant carrots to be eaten cooked, He would have given rabbits
> > fire.
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

