Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWGJA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWGJA2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbWGJA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:28:32 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:53707 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1161275AbWGJA2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:28:31 -0400
Message-ID: <20060710102828.1z89jo3lh6ocsgkc@www.rexursive.com>
Date: Mon, 10 Jul 2006 10:28:28 +1000
From: Bojan Smojver <bojan@rexursive.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
References: <20060627133321.GB3019@elf.ucw.cz>
	<20060709003230.GA1753@elf.ucw.cz>
	<1152407148.2598.10.camel@coyote.rexursive.com>
	<200607091551.18456.rjw@sisk.pl>
In-Reply-To: <200607091551.18456.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:

> The problem is he _can't_ do it on his own if he wants the code merged,
> because for this purpose some people have to review it, and that's not
> only me or Pavel, but also architecture maintainers, memory management
> maintainers, and probably some other people too.  Moreover, Nigel needs
> to address the issues raised by the reviewers.

Of course, of course. Nobody is going to merge anything until relevant  
maintainers approve. That's not what I proposed.

My point is something else. A few months back Pavel mentioned that  
he's thinking of developers more than users when it comes to Suspend2.  
In other words, he was concerned with maintenance of the thing. I'm  
also guessing nobody likes signing their name on something they have  
fundamental design beef with. All valid points, of course.

In order to avoid all this, my proposal introduces Nigel as the  
maintainer of Suspend2 code (i.e. *only* the non-shared bits with  
swsusp/uswsusp).

Given that Nigel:

- doesn't want to rip out/change neither swsusp nor uswsusp
- wants to share code as much as possible
- wants to fix things to be technically acceptable
- has shown to able to maintain Suspend2 codebase for users
- no swsusp/uswsup coder would have to worry about Suspend2 code  
beyond already shared bits they would worry about anyway

I think it would be appropriate to let him do so (once the initial  
technical issues are fixed).

The "your design sucks" argument between Pavel and Nigel is not likely  
to be resolved by more talk (this thread is quite appropriately called  
"history lesson" :-). These two have been at it for months now, with  
no resolution in sight. Yours truly also contributed by useless  
flaming from time to time ;-) No need for that any more.

However, Pavel is the one in the position of power here (being the  
maintainer), so I think he should, in the interest of users, decide to  
give Suspend2 a fair chance (after all those technical issues are  
addressed, of course), by letting Suspend2 be in the same position as  
swsusp or uswsusp - in other words, in the main tree (actually -mm, to  
start with, just as Nigel asked). And with my proposal Pavel and other  
swsusp/uswsusp coders, yourself included, would not have to spend any  
effort past reviewing the initial set of patches.

In the end, it's a win-win.

-- 
Bojan
