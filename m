Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVL3V1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVL3V1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVL3V1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:27:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750852AbVL3V1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:27:12 -0500
Date: Fri, 30 Dec 2005 13:26:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Subject: Re: userspace breakage
In-Reply-To: <1135974176.6039.71.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512301322180.3249@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> 
 <1135798495.2935.29.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
  <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> 
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> 
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>  <20051229202852.GE12056@redhat.com>
  <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>  <20051229224103.GF12056@redhat.com>
  <43B453CA.9090005@wolfmountaingroup.com>  <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
  <43B46078.1080805@wolfmountaingroup.com>  <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
 <1135974176.6039.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Steven Rostedt wrote:
>
> On Thu, 2005-12-29 at 16:10 -0800, Linus Torvalds wrote:
> 
> > Stuff outside the kernel is almost always either (a) experimental stuff 
> > that just isn't ready to be merged or (b) tries to avoid the GPL.
> 
> (c) So damn specialized that it's not worth even trying to merge.
> That's my camp. I'm modifying the kernel so damn much, that I'm doing
> special things for a special purpose, that is so intrusive that I'd be
> laughed out of LKML if I tried to merge it.

Well, that falls under (a) in my opinion.

Some "damn specialized" stuff has actually ended up being merged. It's 
rare, but it happens. The VFS dentry layer is an example of a crazy 
experimental thing that I liked the concept of so much that I merged it, 
and it paid pack handsomely.

So there's just different classes of (a) - ranging from the "not just 
ready yet" to "crazy strange stuff that might never be" ;)

> I _do_ care about kernel bugs that creep in.

Yeah, that goes pretty much without saying.

> I've had a couple of 3's and you've seen those from me.  So although you
> may not be getting the added work I'm doing (you most likely don't even
> want it), at least people like me do help out by doing number 3.

Sometimes the "crazy experimental stuff" ends up being useful even if 
never merged: it gives people ideas of other things to try, and maybe we 
later end up merging something that was inspired by something totally 
crazy. 

So I think the strange specialized stuff can end up being useful in many 
ways, both directly and indirectly.

		Linus
