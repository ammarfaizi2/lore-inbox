Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbSJBLr5>; Wed, 2 Oct 2002 07:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbSJBLr4>; Wed, 2 Oct 2002 07:47:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:45060 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263058AbSJBLrz>; Wed, 2 Oct 2002 07:47:55 -0400
Date: Wed, 2 Oct 2002 13:53:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
Message-ID: <20021002115323.GB13721@atrey.karlin.mff.cuni.cz>
References: <20021001222434.GA2498@elf.ucw.cz> <Pine.NEB.4.44.0210021347090.10143-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210021347090.10143-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- clean/Documentation/swsusp.txt	2002-07-09 04:54:06.000000000 +0200
> > +++ linux-swsusp/Documentation/swsusp.txt	2002-09-25 21:14:42.000000000 +0200
> > @@ -156,6 +156,23 @@
> >  - do IDE cdroms need some kind of support?
> >  - IDE CD-RW -- how to deal with that?
> >
> > +FAQ:
> > +
> > +Q: well, suspending a server is IMHO a really stupid thing,
> > +but... (Diego Zuccato):
> >...
> > +Ethernet card in your server died. You want to replace it. Your
> > +server is not hotplug capable. What do you do? Suspend to disk,
> > +replace ethernet card, resume. If you are fast your users will not
> > +even see broken connections.
> >...
> 
> This sounds as if it might makes even ISA cards hot-pluggable with the
> implication that the drivers might need __devinit/__devexit etc.?

Yes. I'm just not sure if it is worth the effort.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
