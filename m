Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSBIKJo>; Sat, 9 Feb 2002 05:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSBIKJd>; Sat, 9 Feb 2002 05:09:33 -0500
Received: from [63.231.122.81] ([63.231.122.81]:24676 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288821AbSBIKJV>;
	Sat, 9 Feb 2002 05:09:21 -0500
Date: Sat, 9 Feb 2002 03:08:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rob Landley <landley@trommello.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209030825.A9826@lynx.turbolabs.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there>; from landley@trommello.org on Sat, Feb 09, 2002 at 04:27:00AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2002  04:27 -0500, Rob Landley wrote:
> On Friday 08 February 2002 10:39 pm, Andreas Dilger wrote:
> > I don't see why everyone who is using BK is expecting Linus to do a pull.
> > In the non-BK case, wasn't it always a "push" model, and Linus would not
> > "pull" from URLs and such?
> 
> I'd encourage this trend.  If in the future linus pulls from lieutenants and 
> lieutenants pull from maintainers, the dropped patches problem basically goes 
> away.  Just make sure that when the level above you IS ready to take it from 
> your level, it's there and ready for them...

OK, so Linus has been using BK for a couple of weeks now, and some of the
lieutenants have started setting up BK repositories at bkbits.net.  Is
there _any_ way that one can understand the heirarchy of repositories
at bkbits.net?  There's "linus", "linux", "linux25", and a bunch of other
obvious branch repositories.  Which one should kernel developers
clone/pull from?  It would be nice if there was a heirarchy or something
which showed the parent-child relationship.

I suppose (due to the BK design) that it is not fatal if you do your initial
clone from a URL that might go "dead" because you can always change your
parent URL and you haven't lost anything.

Clearly, all of the repositories need to start as clones of Linus'
repository, or there is no chance of them passing CSETs back and forth
among the developers.  Does the fact that 'linux-arm' is apparently not
a descendent from the 'official' linux-2.4 or linux-2.5 repository doom
that developer from not being able to send CSETs to any other kernel
developer or Linus?  Sure, they could send patches, but then they would
forever have to diff/patch and resolve conflicts on their end rather
than just pulling/pushing CSETs with all of the other kernel developers.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

