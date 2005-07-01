Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbVGAIL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbVGAIL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbVGAIL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:11:56 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:38152 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263275AbVGAII5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:08:57 -0400
Message-ID: <42C4FA1A.1050100@slaphack.com>
Date: Fri, 01 Jul 2005 03:08:58 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
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
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org> <20050629205636.GN16867@khan.acc.umu.se>
In-Reply-To: <20050629205636.GN16867@khan.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Wed, Jun 29, 2005 at 04:58:20PM +0300, Markus   Törnqvist wrote:
> 
>>On Wed, Jun 29, 2005 at 09:50:27AM -0400, Douglas McNaught wrote:
>>
>>>I'll just note that the "applications bundled as directories" stuff on
>>>MacOS/NextStep is done completely in userspace--as far as the kernel
>>>is concerned, "Mail.app" is a regular directory.  The file manager
>>>handles recognition and invocation of application bundles (and there
>>>is an 'open' shell command that does the same thing).
>>
>>Note that MacOS has the monopoly on what they ship, Linux has a
>>motherload of file managers and window systems and all.
>>
>>What pisses me off is the fact that Gnome and friends implement
>>their own incompatible-with-others VFS's and automounters and
>>stuff.
>>
>>Surely supporting this in the kernel and extending the LSB
>>to require this is the best step to take without infringing
>>anyone's freedom as such.
>>
>>*still pissed off about having to hassle an automatic mount*
> 
> 
> GNOME and KDE run on operating systems that run other kernels than
> Linux, hence they have to implement their own userland VFS anyway.
> Adding this to the Linux kernel won't help them one bit, unless
> we can magically convince Sun to add it to Solaris, all different
> BSD:s to add it to their kernels, etc.  Not going to happen.
> An effort to get GNOME and KDE to unify their VFS:s would be
> far more benificial,

Than what?  Creating a unified VFS which I can access from Bash, and 
which obsoletes both GNOME and KDE's VFSes except in their presentation?

> FreeDesktop is doing a lot of work to make GNOME, KDE, and other
> DE:s interoperate as much as possible.  Support their initiative
> instead of trying to get a monstrosity (albeit a very cool one,
> conceptually) into the kernel.  Sure, it could be made to work,
> but not without dropping our Unixness.

(I'm talking about the metafs (/meta) idea, which isn't nearly as much a 
monstrocity, and doesn't kill our unixness, it enhances it.)
