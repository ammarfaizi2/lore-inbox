Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSEaNsd>; Fri, 31 May 2002 09:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEaNsc>; Fri, 31 May 2002 09:48:32 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:26118 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316135AbSEaNsc>; Fri, 31 May 2002 09:48:32 -0400
Date: Fri, 31 May 2002 15:48:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020531134818.GC1905@louise.pinerecords.com>
In-Reply-To: <200205302155.g4ULtEb09500@buggy.badula.org> <E17Daa5-0007iZ-00@starship> <20020531011600.ENOZ28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net> <E17Db96-0007iy-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9/sparc SMP
X-Uptime: 1 day, 16:34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I could be wrong but I think Linus wants small patches that slowly
> > convert kbuild24 to kbuild25, and not just a chopped up wholesale
> > kbuild25.
> 
> I hope you're wrong, because that does not sound reasonable.  On the other
> hand, the two build systems coexist quite happily in the same tree.  You
> have to explicitly do the -f Makefile-2.5 for the new build system to kick
> in.  So nobody is being asked to make any sudden change, people can convert
> at their own convenience.

How about a little simile?

Suppose you travel somewhere regularly. You go by train. Then you find out
that switching to bus service would cost you 30% less. Neat!! But hold on,
you are used to going by train -- maybe it's sort of a ritual, like you sit
on the same bench every time and read a newspaper or the conductor's your
friend and you always have a great time chatting with him. But saving 30%
off the traveling costs might be worth sacrifying these pleasures.

What are you going to do? There's no reasonable way to make a transition
from "going by train" to "going by bus," because trains and buses are way
too different. By god, most of the time there's even no toilet in the bus!
Sure, you could go half the route by train and then change to bus, but that
doesn't classify as reasonable with me (it's complicated, eats time and is
certainly expensive). Apparently, the only way to deal with the situation
is to sometimes go by bus and sometimes by train, and eventually cut out
going by train, should you conclude that the switch in your habits pays
off.

--

With that out, I have to say I've never seen so much talk about
something as clear. Let's summarize:

kb25	- is superior to kb24 in one too many aspects
	- is next to impossible to split up "unartificially"
	- coexists with kb24, which provides for the only conceivable
	kind of transition in a change of two greatly diverse systems
	- is transparent and well documented
	- has been spoken in favor of by celebrities (MOST IMPORTANT!! :D)

I'd tell you where the problem lies but I like to avoid saying the obvious.

T.
