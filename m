Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287160AbRL2ICj>; Sat, 29 Dec 2001 03:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287154AbRL2ICU>; Sat, 29 Dec 2001 03:02:20 -0500
Received: from white.pocketinet.com ([12.17.167.5]:63118 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S287153AbRL2IB7>; Sat, 29 Dec 2001 03:01:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Miles Lane <miles@megapathdsl.net>
Subject: Re: State of the new config & build system
Date: Sat, 29 Dec 2001 00:02:07 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au> <WHITELXfKCzxg8cL3zb00000801@white.pocketinet.com> <1009611737.1434.14.camel@stomata.megapathdsl.net>
In-Reply-To: <1009611737.1434.14.camel@stomata.megapathdsl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEXPMzWmf9oqx1xI0000080e@white.pocketinet.com>
X-OriginalArrivalTime: 29 Dec 2001 08:00:22.0653 (UTC) FILETIME=[DDCB12D0:01C1903E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 December 2001 11:42 pm, Miles Lane wrote:
> On Fri, 2001-12-28 at 22:59, Nicholas Knight wrote:
>
> <snip>
>
> > > What Mr. Fishtank seems to overlook is that kbuild 2.5 is far
> > > more flexible and accurate than 2.4, including features that lots
> > > of people want, like separate source and object trees.  Now that
> > > the overall kbuild design is correct, the core code can be
> > > rewritten for speed. And that will be done a couple of weeks
> > > after kbuild 2.5 goes into the kernel, then I expect kbuild 2.5
> > > to be faster than kbuild 2.4 even on full builds.
> >
> > What, exactly, is the point of merging something that nobody is
> > going to use unless they want to test it, in which case they can
> > grab a patch from somewhere?
>
> You don't seem to be reading Keith's message.
>
> The point of merging is that Keith needs time to fix the
> performance problem.  Plus, additional testing would probably
> be helpful.

The performance problem is fixed by a rewrite, which will be done 
shortly after its merge, thus, what is the point of merging now? You 
don't seem to be reading either my message nor Keith's.

>
> > It's half the speed of the current system. The current system
> > works, no matter how horrible its internals can be. That makes the
> > NEW system BROKEN.
>
> No, it's known to be slow in some circumstances.
>
> > If it's KNOWN to be BROKEN prior to merge then it shouldn't
> > even be in a 2.5.*-pre#.
>
> Uh, many drivers cannot be built in the current 2.5 tree.
> Temporary brokenness is acceptable in the development tree.

Oh? Those drivers that cannot be built are a consequence of early work 
to get something ELSE working.
Merging kbuild 2.5 is not *neccisary* to get anything else working in 
2.5, thus so long as it's broken, it should not be merged. What is so 
hard to understand about this?

> It is meant to be _unstable_.  I recall periods when the
> 2.3 kernel was corrupting data for many users.  This period
> lasted about a week, IIRC.  The kbuild 2.5 system will slow

I don't recall there being any intention to cause corruption. There is 
clearly intent here to merge something that shouldn't be.

> people down, but not hose their development system installations.
> I personally think two weeks of working at a slower pace is
> an acceptable trade-off for the longterm benefits that Keith
> has mentioned.

So, it's acceptable to annoy developers and 2.5 testers for two weeks 
because a bad decision was made with full knowledge of the consequences?

> It seems odd that several people in this
> discussion seem to have ignored the repeated statements that
> Keith will have little time for dealing with the performance
> rewrite until the multiple kernel tree synchronization
> time sink goes away. 

Make it go away. This is intended to first be used in 2.5, right? So 
concentraite on getting it WORKING in 2.5, THEN worry about 
backporting. kbuild 2.4 works for 2.4, kbuild 2.5 does not need to be 
maintained for 2.4 now that 2.5 is up. Make it work in 2.5, then worry 
about backporting it. (is there an echo in here?)

> Telling Keith that he needs to go on
> spinning his wheels while he cannot find time to deal with
> the problem you are asking him to fix seems sort of unhelpful.

If he can't find time to fix his own project, it's not my fault, nor is 
it the fault of any kernel developer that he will be irritating the 
shit out of with both the merging and the subsequent problems.

> Perhaps you'd be willing to assist him in the rewrite?

Sure, first you'll need to make me a pro at the language(s) in use.
I've stated repeatedly that I am not a developer for the Linux kernel. 
I'm an annoying guy that tries to give the developers an occasional 
reality check, which usualy fails.

BTW, Jeff Garzik (Legacy Fishtank) just said practicaly the same thing 
I'm saying, why don't you go flame him now?
