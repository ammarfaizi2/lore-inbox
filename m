Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVGAT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVGAT5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVGAT5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:57:06 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:528 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261182AbVGATy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:54:56 -0400
Message-ID: <42C59FA0.1090908@slaphack.com>
Date: Fri, 01 Jul 2005 14:55:12 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
Cc: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org> <20050629205636.GN16867@khan.acc.umu.se> <42C4FA1A.1050100@slaphack.com> <20050701155446.GZ16867@khan.acc.umu.se>
In-Reply-To: <20050701155446.GZ16867@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Fri, Jul 01, 2005 at 03:08:58AM -0500, David Masover wrote:
> 
>>David Weinehall wrote:
>>
>>
>>>GNOME and KDE run on operating systems that run other kernels than
>>>Linux, hence they have to implement their own userland VFS anyway.
>>>Adding this to the Linux kernel won't help them one bit, unless
>>>we can magically convince Sun to add it to Solaris, all different
>>>BSD:s to add it to their kernels, etc.  Not going to happen.
>>>An effort to get GNOME and KDE to unify their VFS:s would be
>>>far more benificial,
>>
>>Than what?  Creating a unified VFS which I can access from Bash, and 
>>which obsoletes both GNOME and KDE's VFSes except in their presentation?
> 
> 
> On one of the platforms that they support, yes.  But only for kernels
> newer than 2.6.yy...  So they'd still have to have their own VFS for
> 2.4.xx, 2.6.xx (xx < yy), FreeBSD, OpenBSD, Solaris, etc...

Right.  But, /proc started somewhere, didn't it?

I have the feeling that other systems will duplicate it if it's good.

Even if they don't, it would be more beneficial to me and probably most 
Linux users to have metafs supported in both GNOME and KDE, even if they 
still need an emulation layer to support other systems.

I agree that the emulation layer should be common.

>>>FreeDesktop is doing a lot of work to make GNOME, KDE, and other
>>>DE:s interoperate as much as possible.  Support their initiative
>>>instead of trying to get a monstrosity (albeit a very cool one,
>>>conceptually) into the kernel.  Sure, it could be made to work,
>>>but not without dropping our Unixness.
>>
>>(I'm talking about the metafs (/meta) idea, which isn't nearly as much a 
>>monstrocity, and doesn't kill our unixness, it enhances it.)
> 
> 
> Which would neither need VFS changes nor be dependent on Reiser4 in
> any way, so I don't see why this thread lives on.  Just get down to
> business and implement this metafs =)

I am trying, at least getting the conceptual glitches ironed out.

But, it does need GNOME/KDE VFS changes in order to be sane -- 
otherwise, GNOME/KDE will duplicate it, creating even more of a mess 
than we already have.

I'm not sure why the thread still lives, but now that I've typed this, I 
may as well send it...
