Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbTCBB2j>; Sat, 1 Mar 2003 20:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269239AbTCBB2i>; Sat, 1 Mar 2003 20:28:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:34951 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S269238AbTCBB2g>;
	Sat, 1 Mar 2003 20:28:36 -0500
Date: Sun, 2 Mar 2003 02:40:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030302014039.GC1364@dualathlon.random>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E615C38.7030609@pobox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 08:19:52PM -0500, Jeff Garzik wrote:
> Alan Cox wrote:
> >On Sun, 2003-03-02 at 00:49, Arador wrote:
> >
> >>On Sat, 1 Mar 2003 16:11:55 -0800
> >>"Adam J. Richter" <adam@yggdrasil.com> wrote:
> >>
> >>(Just a very personal suggestion)
> >>Why to waste time trying to clone a 
> >>tool such as *notrademarkhere*? Why not to support things like subversion?
> >
> >
> >Because the repositories people need to read are in BK format, for better
> >or worse. It doesn't ultimately matter if you use it as an input filter
> >for CVS, subversion or no VCS at all.
> 
> "BK format"?  Not really.  Patches have been posted (to lkml, even) to 
> GNU CSSC which allow it to read SCCS files BK reads and writes.

you never tried what you're talking about.  there's no way to make any
use of the SCCS tree from Rik's website with only the patched CSSC. The
whole point of bitbucket is to find a way to use CSSC on that tree. And
the longer Larry takes to export the whole data in an open format (CVS,
subversion or whatever), the more progress it will be accomplished in
getting the data out of the only service we have right now (Rik's
server). Sure, CSSC is a foundamental piece to extract the data out of
the single files, but CSSC alone is useless. CSSC only allows you to
work on a single file, you lose the whole view of the tree and in turn
it is completely unusable for doing anything useful like watching
changesets, or checking out a branch or whatever else useful thing. As
Pavel found _all_ the info we are interested about is in the
SCCS/s.ChangeSet file and that has nothing to do with CSSC or SCCS.

> 
> Since that already exists, a full BitKeeper clone is IMO a bit silly, 
> because it draws users and programmers away from projects that could 
> potentially _replace_ BitKeeper.

Jeff, please uninstall *notrademarkhere* from your harddisk, install the
patched CSSC instead (like I just did), rsync Rik's SCCS tree on your
harddisk (like I just did), and then send me via email the diff of the
last Changeset that Linus applied to his tree with author, date,
comments etc...  If you can do that, you're completely right and at
least personally I will agree 100% with you, again: iff you can.

Andrea
