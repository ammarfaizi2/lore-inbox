Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267862AbUG3Wdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267862AbUG3Wdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbUG3Wdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:33:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56312 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267859AbUG3Wdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:33:49 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200407301521.03422.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	 <200407300836.32812.jbarnes@engr.sgi.com> <1091225824.5925.1.camel@arrakis>
	 <200407301521.03422.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091226799.5925.4.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Jul 2004 15:33:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 15:21, Jesse Barnes wrote:
> On Friday, July 30, 2004 3:17 pm, Matthew Dobson wrote:
> > On Fri, 2004-07-30 at 08:36, Jesse Barnes wrote:
> > > I think this will work.  My tree didn't have nodemask_t though, so it
> > > didn't compile :)  Here's a first stab at an ia64 portion of the patch.
> > >
> > > Jesse
> >
> > Andrew picked it up in 2.6.8-rc2-mm1, so if you base your patch against
> > that it should compile...  That's what I based my patch off.  Our lab
> > has been down for a few days so I hope to do some testing on Monday for
> > my patches.  If all goes well, I'll add your code into my patch and
> > submit it early next week, ok?
> 
> Sounds good, but it will probably need some fixes before it works correctly 
> (my stuff I mean), so when you have something that looks good give me a few 
> minutes with it before you send it on to Andrew if you would.
> 
> Thanks,
> Jesse

No problem, Jesse.  Like I said, with lab machines being decidedly
unfriendly, I won't even be able to run any real tests on my code until
Monday at the earliest.  I'll certainly give you at least 5 minutes
warning before I post any untested, potentially dangerous code! ;)

-Matt

