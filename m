Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJIL4Y>; Wed, 9 Oct 2002 07:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSJIL4Y>; Wed, 9 Oct 2002 07:56:24 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:49425 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261556AbSJIL4X>; Wed, 9 Oct 2002 07:56:23 -0400
Date: Wed, 9 Oct 2002 14:01:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <Pine.LNX.4.44.0210081830350.4396-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210091243240.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Oct 2002, Linus Torvalds wrote:

> I'm not super-excited about this, partly because of the brouhaha last time
> around on this issue.
>
> This has reasonably distributed config files, and puts the help with the
> config entry where it belongs. Good. It also makes do with just standard
> unix tools, which is going to avoid one particular rat-hole, and which
> makes me at least understand the code. Also good.

Thanks. :)

> But the fact that xconfig depends on QT is going to make some people hate
> it.

This should be rather easily fixable, but it has to be done by someone who
is more familiar with whatever prefered toolkit. I'm familiar with QT and
it's absolutely great to get quickly reasonable results, if someone wants
something else I gladly will help, but I can't do it myself.
The interface to the back end is quite simple so it should be no real
problem to add a different user interface.

> And I haven't actually heard much _about_ this all, because
> (apparently as usual), all the discussion is held in a small world of its
> own.

Well, it happened mostly in my own world, so you didn't miss much. People
seemed to be scared because of the last discussion and are afraid to
invest some time into it. So far I had only some feedback from a few
people (for which I'm already thankful) and it where mostly interface
issues. All the coding work and major design decissions so far are my own.
So what you've seen so far on lkml is pretty much almost all the feedback
I got. It seems unless you state that you're not completely opposed to it,
I'm afraid it won't get better.

> In other words, I really think this needs to pass the linux-kernel stink
> test. Will Al Viro rip your throat out? Will it generate more positive
> feedback than death threats?
>
> Some things made me go eww (but on the whole details):
>
>  - I'd prefer the Config.in name, since this has nothing to do with
>    building, and everything to do with configuration.

Fine with me.
(jgarzik, I think you're overruled now. :) )

>  - I assume that the scripts are generated from the current Config.in
>    and Config.help files, and it would make me slightly happier to see the
>    diff as a "automatic script" + "diff to fix it up", just for doc
>    purposes.

All this is in the archive.

>  - that "lkc" name has got to go. Three-letter acronyms are not good. Of
>    course it's "linux kernel", the whole tree it sits in is "linux
>    kernel". Call it "config" or something obvious, please..

Fine with me too. I don't care much about names (as long as they make
sense) and I thought about a cool name, but I couldn't come up with
something, so if anyone has other suggestions...

>  - Quick testing showed that the first thing I tried didn't work: giving a
>    "?" as answer to the first question did _not_ result in help. "make
>    oldconfig" seemed to do the right thing, though.

Oops,that must have got lost somehow, it's fixed here.

> Let the flames begin.

Thanks, I hope this will help.
(Hmm, I hope your mail still makes it to lkml, in the meantime I left a
few more quotes than I usually would do.)

bye, Roman

