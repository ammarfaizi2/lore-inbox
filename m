Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269258AbTCBSET>; Sun, 2 Mar 2003 13:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269259AbTCBSET>; Sun, 2 Mar 2003 13:04:19 -0500
Received: from [195.223.140.107] ([195.223.140.107]:40076 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S269258AbTCBSER>;
	Sun, 2 Mar 2003 13:04:17 -0500
Date: Sun, 2 Mar 2003 19:16:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030302181615.GA25902@dualathlon.random>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random> <3E623F37.6060005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E623F37.6060005@pobox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 12:28:23PM -0500, Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> >On Sat, Mar 01, 2003 at 08:45:08PM -0500, Jeff Garzik wrote:
> >
> >>Andrea Arcangeli wrote:
> >>
> >>>Jeff, please uninstall *notrademarkhere* from your harddisk, install the
> >>>patched CSSC instead (like I just did), rsync Rik's SCCS tree on your
> >>>harddisk (like I just did), and then send me via email the diff of the
> >>>last Changeset that Linus applied to his tree with author, date,
> >>>comments etc...  If you can do that, you're completely right and at
> >>>least personally I will agree 100% with you, again: iff you can.
> >>
> >>
> >>You're missing the point:
> >>
> >>A BK exporter is useful.  A BK clone is not.
> >>
> >>If Pavel is _not_ attempting to clone BK, then I retract my arguments. :)
> >
> >
> >hey, in your previous email you claimed all we need is the patched CSSC,
> >you change topic quick! Glad you agree CSSC alone is useless and to make
> >anything useful with Rik's *notrademarkhere* tree we need a true
> >*notrademarkhere* exporter (of course the exporter will be backed by
> >CSSC to extract the single file changes, since they're in SCCS format
> >and it would be pointless to reinvent the wheel).
> 
> I have not changed the topic, you are still missing my point.

your point is purerly theorical at this point in time. bitbucker is so
far from being an efficient exporter that arguing right now about
stopping at the exporter or going ahead to clone it completely is a
totally pointless discussion at this point in time.

Once it will be a fully functional exporter please raise your point
again, only then it will make sense to discuss your point.

I'm not even convinced it will become a full exporter if Larry finally
provides the kernel data via an open protocol stored in an open format
as he promised us some week ago, go figure how much I can care what it
will become after it has the readonly capability.

> Let us get this small point out of the way:  I agree that GNU CSSC 
> cannot read the BitKeeper ChangeSet file, which is a file critical for 
> getting the "weave" correct.

This is not what I understood from your previous email:

	"BK format"?  Not really.  Patches have been posted (to lkml, even) to
	GNU CSSC which allow it to read SCCS files BK reads and writes.
	
	Since that already exists, a full BitKeeper clone is IMO a bit silly,

now you're saying something completely different, you're saying, "yes the
CSSC obviously isn't enough and we _only_ _need_ the exporter but please
don't do more than the exporter or it will waste developement
resources". This is why you changed topic as far as I'm concerned, but
no problem, I'm glad we agree the exporter is useful now.

> To me, a "BK clone, read only for now" is vastly different from a "BK 
> exporter".  The "for now" clearly implies that it will eventually 
> attempt to be a full SCM.

Why do you care that much now? I can't care less. Period. I need the
exporter and for me the exporter or the bk-clone-read-only is the same
thing, I don't mind if I've to run `bk` or `exportbk` or rsync or
whatever to get the data out.

If bitbucket will become much better than bitkeeper 100 years from now,
much better than a clone, is something I can't care less at this point
in time, and it may be the best or worst thing it will happen to the
whole SCM open source arena, you can't know, I can't know, nobody can
know at this point in time.

You agreed the exporter is useful, so we agree, I don't mind what will
happen after the useful thing is avaialble, it's the last of my worries,
and until we reach that point obviously there is no risk to reinvent the
wheel (unless the data become available in a open protocol first).

> Why do we need Yet Another Open Source SCM?
> Why does Pavel not work on an existing open source SCM, to enable it to 
> read/write BitKeeper files?

bitbucket could be merged into any SCM at any time, it is _the
exporter_ that the other SCM needs to import from the *notrademarkhere*
trees.

> These are the key questions which bother me.
> 
> Why do they bother me?
> 
> The open source world does not need yet another project that is "not 
> quite as good as BitKeeper."  The open source world needs something that 
>  can do all that BitKeeper does, and more :)  A BK clone would be in a 
> perpetual state of "not quite as good as BitKeeper".

Disagree, if it will become more than an read-only thing, it will likely
become as good and most probably better than bitkeeper (maybe not
graphical but still usable) because it means it has the critical mass of
developement power _iff_ it can reach that point. But at this point in time
I doubt it will become more than an exporter, infact I even doubt it
will become a fully exporter if Larry avoids us to waste time. I
personally would have no interest in bitbucket if Linus would provide
the data in a open protocol for efficient downloads and in a open format
for backup-archive downloads as we discussed some week ago.

But again, what bitbucket will become after it will be a function
exporter (i.e. your "point") is enterely pointless to argue about right
now IMHO. But feel free to keep discussing it with others if you think
it matters right now (now that I made my point clear, I probably won't
feel the need to answer since my interest in that matter is so low).

Andrea
