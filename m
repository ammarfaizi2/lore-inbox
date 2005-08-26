Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVHZVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVHZVJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVHZVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:09:40 -0400
Received: from web33309.mail.mud.yahoo.com ([68.142.206.124]:42935 "HELO
	web33309.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030189AbVHZVJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:09:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3rfTrtmSx3rWvC7lmlmlN3mpXSogo7clz8FIR9oQFwULw7Sop3jgGEXuHi9mxrwTfRsndWv1T3uE1Eg2IE23hGj+mVcct9oS1WsnhCQ/oK9+miTTmXvnzXAp5PzfwPRZbA/1cfJW+Wj1Kr/MBx1LrudcaZX9JSkenJ5JuGkHudY=  ;
Message-ID: <20050826210931.63327.qmail@web33309.mail.mud.yahoo.com>
Date: Fri, 26 Aug 2005 14:09:31 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050826183019.GI6471@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Aug 26, 2005 at 10:06:51AM -0700,
> Danial Thom wrote:
> >...
> > I don't think I'm obligated to answer every
> > single person who pipes into a thread. People
> who
> > say "show me your config and dmesg" are not
> > useful. Linux has long had a philisophical
> > problem of dropping packets as a "performance
> > feature", and we've already established I
> think
> > that you can't eliminate it altogether, if
> you
> > read the thread carefully.
> >...
> 
> You say you have observed for a long time a
> problem.
> 
> The only person participating in this thread
> who is one of the 
> networking maintainers is Patrick McHardy.
> 
> Did _he_ say this was a known and unfixable
> problem?

I don't know. He said that the network stack  has
absolute priority, so perhaps he can explain why
compiling a kernel causes an exponential increase
in packet loss? 

The FreeBSD "network maintainers" are largely
clueless about just about every problem in 5.x,
so I'm not sure the title qualifies someone as
knowing all there is to know. I haven't heard him
claim that he can do the things I'm doing without
any receive errors or drops. I'd like to hear
about what test he runs to test this sort of
problem.

Before you can solve a problem you have to have a
clear understanding of what the problem is, and
admit that you have a problem. 
> 
> He wanted to help you and you pissed him off
> because you refuxed to give 
> him dmesg, .config and other information that
> would have helped him to 
> debug your problem. If you don't feel obliged
> to help the persons 
> responsible for the part of the kernel you have
> a problem with to debug 
> your problem your whole initial mail was
> pointless.

I didn't refuse. I just chose to take help from
Ben, because Ben took the time to reproduce the
problem and to provide useful settings that made
sense to me. There's nothing wrong with my
machine. 

I don't know who is who; I judge people based on
the intelligence of their analysis. People
responsible for the network stack may not be the
right people, because this is more likely a
scheduler issue. There's probably nothing wrong
with the stack or the drivers; the machine just
doesn't react fast enough to avert ring overruns.

DT



		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

