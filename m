Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVCCIio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVCCIio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCCIio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:38:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61061 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261633AbVCCIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:38:40 -0500
Message-ID: <4226CCFE.2090506@pobox.com>
Date: Thu, 03 Mar 2005 03:38:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com>
In-Reply-To: <20050303081958.GA29524@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Mar 02, 2005 at 05:15:36PM -0800, Linus Torvalds wrote:
> 
>>The thing is, I _do_ believe the current setup is working reasonably well.  
>>But I also do know that some people (a fairly small group, but anyway)  
>>seem to want an extra level of stability - although those people seem to
>>not talk so much about "it works" kind of stability, but literally a "we
>>can't keep up" kind of stability (ie at least a noticeable percentage of
>>that group is not complaining about crashes, they are complaining about
>>speed of development).
>>
>>And I suspect that _anything_ I do won't make those people happy.
> 
> 
> That single sentence sums it up perfectly.  When I have given talks
> about how our current development cycle works, and what's happening with
> it, people just feel odd seeing all of this change happen and get upset
> at it.  Perhaps it's because they never paid attention before, or that
> they are new to Linux and like to believe that old-style development
> models were somehow "better", and that they know we are doing something
> wrong.
> 
> But when pressed about the issue of speed of development, rate of
> change, feature increase, driver updates, and so on, no one else has any
> clue of what to do.  They respond with, "but only put bugfixes into a
> stable release."  My comeback is explaining how we handle lots of
> different types of bugfixes, by api changes, real fixes, and driver
> updates for new hardware.  Sometimes these cause other bugs to happen,
> or just get shaken out where they were previously hiding (acpi is a
> great example of this issue.)  In the end, they usually fall back on
> muttering, "well, I'm just glad that I'm not a kernel developer..." and
> back away.

The pertinent question for a point release (2.6.X.Y) would simply be 
"does a 2.6.11 user really need this fix?"


> Like I previously said, I think we're doing a great job.  The current
> -mm staging area could use some more testers to help weed out the real
> issues, and we could do "real" releases a bit faster than every 2 months
> or so.  But other than that, we have adapted over the years to handle
> this extremely high rate of change in a pretty sane manner.

I think Linus's "even/odd" proposal is an admission that 2.6.X releases 
need some important fixes after it hits kernel.org.

Otherwise 2.6.X is simply a constantly indeterminent state.

We need to serve users, not just make life easier for kernel developers ;-)

	Jeff


