Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbTCGW5D>; Fri, 7 Mar 2003 17:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTCGW5D>; Fri, 7 Mar 2003 17:57:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261839AbTCGW5B>; Fri, 7 Mar 2003 17:57:01 -0500
Date: Fri, 7 Mar 2003 15:05:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
Message-ID: <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Roman Zippel wrote:
> > 
> > Put the two together, and the GPL really doesn't look like a very good 
> > license for klibc. Yeah, you can disagree about what the actual exceptions 
> > are, but clearly there has to be _some_ exception to the license.
> 
> This really doesn't speak against the GPL, if we do something similiar as 
> libgcc.

Sure. GPL with restrictions might work fine.

> Well, there wasn't much to argue against yet so far :), I'm still trying 
> to find the reason for Peters decision.

That I can't answer. I don't personally think that BSD/MIT is any better 
than GPL with restriction, and the real issue boils down to "what license 
do people want to work on". Since Peter so far has been one of the major 
developers, his opinion (regardless of _why_ he holds that opinion) 
matters more than most to me.

Of course, some people have said that _they_ would want to work on it only 
if it's GPL, but hey, the proof is in the pudding, and "A bird in the hand 
is worth two in the bush". In other words, talk is cheap, and code rules. 
Right now that means that hpa rules, methinks.

However, I also have to say that klibc is pretty late in the game, and as 
long as it doesn't add any direct value to the kernel build the whole 
thing ends up being pretty moot right now. It might be different if we 
actually had code that needed it (ie ACPI in user space or whatever).

		Linus

