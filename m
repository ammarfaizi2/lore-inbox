Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317820AbSFMUia>; Thu, 13 Jun 2002 16:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317821AbSFMUi3>; Thu, 13 Jun 2002 16:38:29 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:36842
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317820AbSFMUi2>; Thu, 13 Jun 2002 16:38:28 -0400
Date: Thu, 13 Jun 2002 13:37:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Keith Owens <kaos@ocs.com.au>,
        Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>,
        linux-kernel@vger.kernel.org, xsdg <xsdg@openprojects.net>
Subject: Re: [patch] early printk. (was: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs)
Message-ID: <20020613203753.GV13541@opus.bloom.county>
In-Reply-To: <17757.1023845630@kao2.melbourne.sgi.com> <Pine.LNX.4.44.0206120825510.4043-100000@elte.hu> <20020612172754.C87@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 05:27:54PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > >>Then, after a small pause, the box reboots (note: it does _not_ print
> > > >>"Uncompressing Linux...").  I have tried the following:
> > > >
> > > >Interesting problem.....  Interesting because I'm having the EXACT
> > > >SAME PROBLEM!!!!  ARRRRRGGGGHHH!!!!
> > > 
> > > Try http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2
> > 
> > you might as well try the attached early_printk() patch, it's slightly
> > easier to use than a one-char macro. But the goal is the same.
> 
> Could this be arch-independend? x86-64 has it, too, and AFAIR it was taken
> from ia64.. Plus, it is *very* usefull.

>From looking at the patch, that looks horribly i386 (and related)
specific.

And FYI PPC has had something similar (CONFIG_BOOTX_TEXT, and in 2.5
CONFIG_SERIAL_TEXT_DEBUG) for a while now.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
