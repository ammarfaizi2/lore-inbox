Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132086AbRAXAtW>; Tue, 23 Jan 2001 19:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132209AbRAXAtM>; Tue, 23 Jan 2001 19:49:12 -0500
Received: from tech1.nameservers.com ([216.46.160.19]:61191 "EHLO
	tech1.nameservers.com") by vger.kernel.org with ESMTP
	id <S132086AbRAXAtE>; Tue, 23 Jan 2001 19:49:04 -0500
Message-Id: <200101240049.QAA14815@tech1.nameservers.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Re: Turning off ARP in linux-2.4.0 
In-Reply-To: Your message of "Wed, 24 Jan 2001 01:38:00 +0100."
             <20010124013800.A12632@gruyere.muc.suse.de> 
Date: Tue, 23 Jan 2001 16:49:04 -0800
From: Pete Elton <elton@iqs.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 23, 2001 at 04:27:21PM -0800, Pete Elton wrote:
> > Any ideas on how I can turn off the arping?  I guess the thing that I 
> 
> I explained it in my last mail how to do it using arpfilter. I do not claim 
> that it is an elegant solution.
> It's probably not worse a hack than hidden is in the first place though.

I either missed that or did not understand it.  I am now rereading your
message....

Is that what you were referring to when you said
	only try to use policy routing hacks (not tested). e.g. tag all outgoing 
	packets with a specific fwmark that redirects them to a specific routing
	table which does the real routing, and put no routes into the normal 
	one used by arpfilter so that it doesnt' reply.

I am not familiar with policy routing.  Could you point me to some
docs I could read or maybe even give a trivial example to start me
on the right path?

> > am most curious about is how it ending up being removed from the kernel
> > in the first place.  It must have been a decision that someone made.
> > Either, we don't need that any more since we can do it this way, or
> > we'll take it out since nobody uses it.
> 
> It was only submitted to 2.2 a few months ago (=years after 2.3 branched), b
>     ut 
> never added to 2.4. 

Well that at least makes sense as to why it's not in there.

Thank you for all of your help.

Pete

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
