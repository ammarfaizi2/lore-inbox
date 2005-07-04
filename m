Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVGDSrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVGDSrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVGDSrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:47:42 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:5643 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261564AbVGDSrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:47:32 -0400
Message-ID: <42C98444.5090909@slaphack.com>
Date: Mon, 04 Jul 2005 13:47:32 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Weinehall <tao@acc.umu.se>,
       =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507020148.j621m9m0006559@laptop11.inf.utfsm.cl>
In-Reply-To: <200507020148.j621m9m0006559@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>David Weinehall wrote:
>>
>>>On Fri, Jul 01, 2005 at 03:08:58AM -0500, David Masover wrote:
>>>
>>>>David Weinehall wrote:
> 
> 
>>>>>GNOME and KDE run on operating systems that run other kernels than
>>>>>Linux, hence they have to implement their own userland VFS anyway.
>>>>>Adding this to the Linux kernel won't help them one bit, unless
>>>>>we can magically convince Sun to add it to Solaris, all different
>>>>>BSD:s to add it to their kernels, etc.  Not going to happen.
>>>>>An effort to get GNOME and KDE to unify their VFS:s would be
>>>>>far more benificial,
> 
> 
>>>>Than what?  Creating a unified VFS which I can access from Bash,
>>>>and which obsoletes both GNOME and KDE's VFSes except in their
>>>>presentation?
> 
> 
>>>On one of the platforms that they support, yes.  But only for kernels
>>>newer than 2.6.yy...  So they'd still have to have their own VFS for
>>>2.4.xx, 2.6.xx (xx < yy), FreeBSD, OpenBSD, Solaris, etc...
> 
> 
>>Right.  But, /proc started somewhere, didn't it?
> 
> 
> Sun.
> 
> 
>>I have the feeling that other systems will duplicate it if it's good.
> 
> 
> Linux copied here.

So what?

>>Even if they don't, it would be more beneficial to me
> 
> 
> How, exactly?

Go back and read.

> Besides, /your/ convenience isn't the only thing that matters...

Nor yours.  Just because you can't get your mind around a concept 
doesn't mean that it's a bad concept, and that no one else can use it.

>>                                                      and probably
>>most Linux users
> 
> 
> "Most Linux users" don't use experimental filesystems at all...

Actually, they do -- ext3 was experimental once.  ReiserFS was very 
experimental once.

Please stop bashing it just because it's new/experimental.

>>                 to have metafs supported in both GNOME and KDE, even
>>if they still need an emulation layer to support other systems.
> 
> 
> So Gnome and KDE get larger (and thus slower) for everybody.

Smaller (and thus faster) on supported systems, otherwise exactly the 
same, but maybe a little more modular, which is good.

> Besides, Gnome
> and KDE will have to agree on the formats involved first, which is /exactly/
> what is supposed to be impossible unless this stuff is implemented in the
> kernel...

I never said that, but for one thing, whether they do or not, it's nice 
if my shell and my editor and all the other things that I use don't have 
to agree on anything to manipulate the formats involved.

This is not just about GNOME/KDE.  It is about GNOME/KDE not developing 
an additional layer, that you wouldn't like anyway, that cannot be 
accessed from anything except GNOME/KDE.

