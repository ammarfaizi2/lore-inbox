Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264293AbRFGDHg>; Wed, 6 Jun 2001 23:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264295AbRFGDH0>; Wed, 6 Jun 2001 23:07:26 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:39697 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S264293AbRFGDHU>;
	Wed, 6 Jun 2001 23:07:20 -0400
Subject: Re: Break 2.4 VM in five easy steps
From: Miles Lane <miles@megapathdsl.net>
To: Mike "A." Harris <mharris@opensourceadvocate.org>
Cc: Derek Glidden <dglidden@illusionary.com>,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106062032390.26171-100000@asdf.capslock.lan>
In-Reply-To: <Pine.LNX.4.33.0106062032390.26171-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 20:13:32 -0700
Message-Id: <991883613.15447.0.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Jun 2001 20:34:49 -0400, Mike A. Harris wrote:
> On Wed, 6 Jun 2001, Derek Glidden wrote:
> 
> >>  Derek> overwhelmed.  On the system I'm using to write this, with
> >>  Derek> 512MB of RAM and 512MB of swap, I run two copies of this
> >>
> >> Please see the following message on the kernel mailing list,
> >>
> >> 3086:Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> >> Message-Id: <E155bG5-0008AX-00@the-village.bc.nu>
> >
> >Yes, I'm aware of this.
> >
> >However, I still believe that my original problem report is a BUG.  No
> >matter how much swap I have, or don't have, and how much is or isn't
> >being used, running "swapoff" and forcing the VM subsystem to reclaim
> >unused swap should NOT cause my machine to feign death for several
> >minutes.
> >
> >I can easily take 256MB out of this machine, and then I *will* have
> >twice as much swap as RAM and I can still cause the exact same
> >behaviour.
> >
> >It's a bug, and no number of times saying "You need twice as much swap
> >as RAM" will change that fact.
> 
> Precicely.  Saying 8x RAM doesn't change it either.  Sometime
> next week I'm going to purposefully put a new 60Gb disk in on a
> separate controller as pure swap on top of 256Mb of RAM.  My
> guess is after bootup, and login, I'll have 48Gb of stuff in
> swap "just in case".

Mike and others, I am getting tired of your comments.  Sheesh.  
The various developers who actually work on the VM have already
acknowledged the issues and are exploring fixes, including at 
least one patch that already exists.  It seems clear that the 
uproar from the people who are having trouble with the new VM's 
handling of swap space have been heard and folks are going to 
fix these problems.  It may not happen today or tomorrow, but 
soon.  What the heck else do you want?

Making enflammatory remarks about the current situation does 
nothing to help get the problems fixed, it just wastes our time 
and bandwidth.

So please, if you have new facts that you want to offer that
will help us characterize and understand these VM issues better
or discover new problems, feel free to share them.  But if you
just want to rant, I, for one, would rather you didn't.

	Miles

