Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbTCPVlg>; Sun, 16 Mar 2003 16:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262768AbTCPVlg>; Sun, 16 Mar 2003 16:41:36 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:62352 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262763AbTCPVle>;
	Sun, 16 Mar 2003 16:41:34 -0500
Date: Sun, 16 Mar 2003 22:52:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nicolas Pitre <nico@cam.org>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030316215219.GX1252@dualathlon.random>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303162014090.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303162014090.12110-100000@serv>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ hoping this is the last email in this thread, I know I'm not
  contributing to this reach this objective :) ]

On Sun, Mar 16, 2003 at 08:33:18PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 16 Mar 2003, Nicolas Pitre wrote:
> 
> > > The missing bits are absolutely not worthless. They are very useful when 
> > > you want to test other SCM system to simulate distributed development.
> > 
> > This is completely ridiculous.  Isn't this a bit too demanding?
> 
> Not really, it's actually more simple to what Larry is currently offering. 
> easy to add as well. If you now also add a sequence number is quite simple 
> to modify a CVS server which can export the data reliably.

CVS basically exports RCS through the network, your argument makes no
sense to me, what's the difference, I don't see what you mean.

> > Be realistic.  The missing bits are worthless and add absolutely no value to 
> > kernel development which is supposed to be the topic for this mailing list.  
> 
> If you want to test an alternative system to see whether it's usable for 
> kernel development, what better data is there? How could you compare it 
> against bk?

Larry has all the rights to not to help providing a testcase, it makes
no sense for you to complain he's not providing a testcase for a
competitive system. It make no sense just like complaining that if Larry
changes the bk format to something encrypted compressed or .doc. he has
the rights to do it, so please stop raising pointless arguments.

You could make a bit more of sense if your argument was that you still
miss the visibility on the jfs developement or similar, but the fact a
"testcase" for a competitive SCM this way is missing makes no sense at
all. Infact a much testcase is not missing! just give us the alternative
open SCM and we'll be glad to try using it in real life, which is an
order of magnitude better testcase than feeding the old data into the
repository offline.

If you're still unhappy now that the mainline data is open it means
you're either a jfs developer (but I assume they're all fine with bk
since they're just using it, so I doubt this is the case) or your
problem is that you don't like the fact that Linux is still developed
with proprietary software but in such case go speak with Linus not with
Larry.

>From my part - now that the full data and metadata of the main branch is
available in the open in a usable form - I have no problem anymore with
Linus using bitkeeper. I'm not religious about Linux, I'm only religious
about my freedom. Sure, now I would like if Linus and Marcelo would be
the only one using bitkeeper (so CVS would miss zero info), yes, but
really all other branches are of nearly zero interest to me compared to
the main branch and usually important branches like the jfs one (I don't
know the others since I can't see them, I only know the jfs one because
it gave me troubles with bkweb, this is why I'm only mentioning such
one) can be retrieved via other methods (like asking the developers by
emails).

Now I need to write tools to extract the stuff and parse it with more
intelligent software than CVS, one of those tools is just available, so
please stop these complains, and help writing a reliable changelog
extractor using the dates and verifying the stuff with the logic tag. It
doesn't matter if the CVS protocol is good or bad, as far as the whole
mainline kernel evolution data is available reliably in the open, so
from my part I'm extremely happy because I finally have a chance to
start appreciating the advantages of Linus and Marcelo using bitkeeper ;)

Andrea
