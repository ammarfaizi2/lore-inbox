Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSFMTMI>; Thu, 13 Jun 2002 15:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317801AbSFMTMH>; Thu, 13 Jun 2002 15:12:07 -0400
Received: from [195.39.17.254] ([195.39.17.254]:38307 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317799AbSFMTMH>;
	Thu, 13 Jun 2002 15:12:07 -0400
Date: Wed, 12 Jun 2002 17:27:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Keith Owens <kaos@ocs.com.au>, Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>,
        linux-kernel@vger.kernel.org, xsdg <xsdg@openprojects.net>
Subject: Re: [patch] early printk. (was: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs)
Message-ID: <20020612172754.C87@toy.ucw.cz>
In-Reply-To: <17757.1023845630@kao2.melbourne.sgi.com> <Pine.LNX.4.44.0206120825510.4043-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>Then, after a small pause, the box reboots (note: it does _not_ print
> > >>"Uncompressing Linux...").  I have tried the following:
> > >
> > >Interesting problem.....  Interesting because I'm having the EXACT
> > >SAME PROBLEM!!!!  ARRRRRGGGGHHH!!!!
> > 
> > Try http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2
> 
> you might as well try the attached early_printk() patch, it's slightly
> easier to use than a one-char macro. But the goal is the same.

Could this be arch-independend? x86-64 has it, too, and AFAIR it was taken
from ia64.. Plus, it is *very* usefull.
									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

