Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268650AbTCCWGQ>; Mon, 3 Mar 2003 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268651AbTCCWGQ>; Mon, 3 Mar 2003 17:06:16 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5892 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268650AbTCCWGO>;
	Mon, 3 Mar 2003 17:06:14 -0500
Date: Mon, 3 Mar 2003 01:10:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030303001032.GD319@elf.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E615C38.7030609@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>(Just a very personal suggestion)
> >>Why to waste time trying to clone a 
> >>tool such as bitkeeper? Why not to support things like subversion?
> >
> >
> >Because the repositories people need to read are in BK format, for better
> >or worse. It doesn't ultimately matter if you use it as an input filter
> >for CVS, subversion or no VCS at all.
> 
> "BK format"?  Not really.  Patches have been posted (to lkml, even) to 
> GNU CSSC which allow it to read SCCS files BK reads and writes.
> 
> Since that already exists, a full BitKeeper clone is IMO a bit silly, 
> because it draws users and programmers away from projects that could 
> potentially _replace_ BitKeeper.

Read-only access to the bk repositories is the first goal. Then, I'll
either add write support (unlikely) or feed it into some existing
version control system to work with that. I'm still not sure what's
the best.

[bk's on-disk format is quite reasonable; it might be okay to reuse
that.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
