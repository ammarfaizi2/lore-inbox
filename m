Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVBHO5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVBHO5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVBHO5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:57:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:43755 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261151AbVBHO5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:57:23 -0500
Date: Tue, 8 Feb 2005 15:57:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050207021030.GA25673@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502071516100.30794@scrub.home>
References: <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org>
 <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet>
 <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr>
 <20050204160631.GB26748@bitmover.com> <Pine.LNX.4.61.0502060025020.6118@scrub.home>
 <20050206173910.GB24160@bitmover.com> <Pine.LNX.4.61.0502061859000.30794@scrub.home>
 <20050207021030.GA25673@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Feb 2005, Larry McVoy wrote:

> [Larry continues to pull numbers out of his arse.]

Out of sympathy to Al I cut the crap short. If you (or anyone else) really 
want to know, contact me privately.
The 85% number is of secondary interest only anyway, my (undisputed) 
argumentation still stands, why the 44% is more important.

> > Well, I'm not the one who claimed "We don't do lockins.  Period."
> > I'm just trying to figure out what that means...
> 
> Hey, Roman, the statement above stands.  You made the choice that you want
> to go write a competing system.  If you hadn't you could just use BK and
> stop whining.  Since you have made that choice, which is your right,
> how about you produce your competing system?  And stop whining that
> we aren't giving you enough help.  What is that you say?  It's hard?
> It's way harder if we don't give you a roadmap?  Well gosh darn, that
> must really suck for you.  I'm really sorry that you can't figure it out
> without our help but that's sort of the whole point, isn't it?  

1. Is the kernel history locked into bk?
Fact is that exporting the history from bk into a different system 
requires extensive scm knowledge, which makes it rather unlikely that a bk 
user can do this by himself. He also has various resaons to not ask for 
such help, from that he just doesn't care to that he is afraid bk support 
might be pulled.
This leaves the other users, which either can't or want to use bk, with 
a reduced kernel history (as I have shown in the previous mails). The 
practical consequence of this is that a majority of the kernel history is 
locked into bk right now, with no way in sight to get it out of there.

2. Larry, do you really thought that kernel hackers have no other 
interests than kernel hacking? Do you really thought that all kernel 
hackers want to keep the kernel history forever in bk?
I never really wanted to use bk in first place and at that time the 
license was annoying but I would have at least used it to push changes to 
other bk users. The main reason I don't use bk was and is technical, it 
simply doesn't do what I need. The license change just made it completely 
unacceptable to even bother. So while I don't care much about bk, I care 
of course about the kernel data and only this really sparked my interest 
into scm systems. Isn't it ironic that without that license change I 
likely wouldn't know as much about scm systems as I do now?
Anyway, if I wanted to write a simple bk clone, I could have done so 
already easily without your help, but why should I do so if it's not 
what I need in first place? Sorry to disappoint your ego, but the world 
doesn't center around bk. Did you know, there are other scm systems out 
there? Once one studied a few of them, one basically also knows how bk 
works and it certainly helps to put your "facts" into perspective.

Assuming I wrote such a "competing system". What would it change? Could I 
or anyone else then import the kernel data into it? How would a user 
proceed in order to convert his data, so he can give such a system a real 
test run?
Well, from your perspective I'm propably already working on a "competing 
system", from mine I'm just playing around with some ideas from time to 
time, but you certainly keep encouraging me to keep on it and to develop 
them into something usable. It's not really a problem to continue using 
the bkcvs kernel tree or any other large cvs tree for testing, the bk 
data doesn't contain any information I don't know already. 

Finally the main question remains (and it will come up over and over 
again), how can I or anybody else get my data back out of bk? How can you 
claim the kernel history is not property of BM and OTOH the publically 
available data is provably not complete? You can continue to use my 
interest in scm systems to discredit me as much as you want, but I doubt 
we will ever find a suitable candidate, AFAICT anyone only remotely 
suggesting using the data in an out of bk context got pretty much the same
treatment from you. Larry, could you please explain, how you exactly 
intend to keep the evil scm developers out and at the same time leave 
users a choice in their tools once they put their data into bk?

bye, Roman
