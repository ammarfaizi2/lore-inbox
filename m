Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289899AbSAPJKQ>; Wed, 16 Jan 2002 04:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289891AbSAPJKH>; Wed, 16 Jan 2002 04:10:07 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:46734 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289899AbSAPJJ4>; Wed, 16 Jan 2002 04:09:56 -0500
Message-Id: <200201151353.g0FDrGSs001770@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Mon, 14 Jan 2002 14:50:35 EST." <20020114145035.E17522@thyrsus.com> 
Date: Tue, 15 Jan 2002 14:53:16 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> arjan@fenrus.demon.nl <arjan@fenrus.demon.nl>:
> > Of course there are other settings that do have impact (CPU type mostly,
> > maybe memory layout) but other than that... distros already ship several
> > binary versions (last I counted Red Hat ships 11 or so with RHL72) to
> > account for CPU type and amount etc.
> 
> OK.  Scenario #2:
> 
> Tillie's nephew Melvin is a junior-grade geek.  He's working his way
> through college doing website administration for small businesses.  He
> doesn't know C, but he can hack his way around Perl and a little PHP,
> and he can type "configure; make".  He's been known to wear a penguin
> T-shirt.

> [Melvin needs a hand-tailored kernel for a crappy webserver. Source is
>  _long_ gone]

Melvin is a html-only geek, but not stupid. He knows where he can get the
sources for the distribution's kernel, and he knows very well that it is
advisable to stick to the distribution's software. He understands enough of
the process so he can tailor a kernel for _webserving_, not optimal use of
all hardware on Ye Olde Coffepot. He leaves out sound, serial support, and
acceleration support for the video card (What for in a webserver?),
configures floppy and CD as modules (to save the odd byte), just ext3 as
builtin filesystem (no need for all the others, iso9660 is module for some
savings). He includes iptables support, but no connection tracking or NAT
modules. All things an autoconfigurator wouldn't dream of doing on its own.

[Again, building a tailored kernel for a specific application on a crappy
 machine is no place for automatism; for everything else an Aunt Tillie
 might need a "get nearest size" is enough]

[...]

> "Crap." Melvin thinks.  "I don't remember what kind of network card I
> compiled in.  Am I going to have to open this puppy up just to eyeball
> the hardware?" Doing that would take time Melvin was planning to spend
> chatting up a girl geek he's noticed over at the computer lab.

If Melvin did compile the kernel in the first place, he is smart enough to
keep .configure around. If not, he doesn't deserve getting laid.

For terminally stupid Melvins, keep .configure around somewhere.
-- 
Horst von Brand			     http://counter.li.org # 22616
