Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317144AbSFBH6Z>; Sun, 2 Jun 2002 03:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317147AbSFBH6Y>; Sun, 2 Jun 2002 03:58:24 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:5260 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317144AbSFBH6X>; Sun, 2 Jun 2002 03:58:23 -0400
Date: Sun, 2 Jun 2002 01:58:10 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, Keith Owens <kaos@ocs.com.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.44.0206020139510.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Jun 2002, Ion Badulescu wrote:
> On Fri, 31 May 2002, Daniel Phillips wrote:
> FUD? Heh. No, it's a simple question and you haven't answered it.

It fit happily into the "noone is willing to maintain kb25" cliche.

BTW, I think I will release a patch against linux 0.01 which will 
introduce all the features of the current linus tree in a few minutes. Why 
calling it linux 2.5.19? It has the features! Yet I'm patching it, if you 
want piecemeal, grab the list.

> And that's precisely the wrong way to break it up. You'll waste your time
> and you'll probably hit Linus' bit bucket in no time. Thank you very much,
> but I can split patches based on the files they touch by myself, I don't
> need your help.

I split it so that you can merge some stuff in and it has no effect. You 
can even merge the whole thing in with no effect as long as you're using 
the old Makefile,v 2.4.

> What you and other very vocal proponents of kbuild25 don't understand is 
> that you need break it up __functionally__. That is, add one feature at a 
> time. That way, good features can be added without much of a discussion, 
> and debatable features can be, well, debated.

I'm not exactly german. I'm in germany, currently, but what does it tell 
you? And before you ask, I never answer questions about my nationality. 
And anyway, they don't belong to linux-kernel in any way.

For the most features you'll at first need the core, or you merge it in, 
and later pull it from the kernel again to introduce it with core support. 
Diffing into every single feature _can_ be done, but I'll be kicked off 
the list if I post them one by one.

> Unfortunately, I don't see Keith doing this anytime soon. He's too much in 
> love with his baby to risk seeing parts of it being thrown away, so he's 
> taking an all-or-nothing attitude.

It's more or less because it is quite silly to post every single feature, 
and lethal for kernel development on this list.

> Fortunately, it is precisely what Kai is doing. He deserves a big THANKS 
> for doing it, not your silly bashing. I also saw some good work on this 
> from Sam Ravnborg on the list.

See my statement about linux-0.01.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

