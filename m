Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVHVXy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVHVXy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVHVXy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:54:27 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:55055
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S1751256AbVHVXy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:54:26 -0400
Date: Mon, 22 Aug 2005 16:48:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: IT8212/ITE RAID
In-Reply-To: <58cb370e0508220228770415f7@mail.gmail.com>
Message-ID: <Pine.LNX.4.10.10508221643170.6541-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WHOA Gents!

Let me get some popcorn to watch this p-contest.
The way you guys are sniping at each other sounds like the good-old days,
when everyone railed me and the subsystem and ended up railing back

Guess nothing was learned from the 6+ years of flamage.

I have mellowed out with age ...

Bart, give Alan a break ... his is genrally right at the end of the day.

Alan, give Bart a break ... cause there is no way I am coming back for a
three-pete.

Cheers,

Andre

On Mon, 22 Aug 2005, Bartlomiej Zolnierkiewicz wrote:

> Any news about URLs?  It shouldn't be too hard find them unless they
> never existed in the first place. I will work on the issues immediately.
> 
> Bartlomiej
> 
> On 8/14/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 8/14/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > On Sul, 2005-08-14 at 17:56 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > * your stuff was accepted after all (and some stuff like ide-cd
> > > >   fixes was never splitted from the -ac patchset and submitted)
> > >
> > > They were.
> > 
> > I remember discussion about end-of-media ide-cd fixes but the patch
> > was never submitted.  If you have *URL* to the patch I'll work on the patch.
> > 
> > > > * you've never provided any technical details on "the stuff I broke"
> > >
> > > I did, several times. I had some detailed locking discussions with
> > > Manfred and others on it as a result. The locking in the base IDE is
> > > still broken, in fact its become worse - the random locking around
> > > timing changes now causes some PIIX users to see double spinlock debug
> > > with the base kernel as an example.
> > 
> > Huh?  *WHICH* my patch causes this?
> > 
> > I don't remember this discussion et all, care to give some pointers?
> > 
> > > > > Would make sense, but I thought I had the right bits masked. Will take a
> > > >
> > > > WIN_RESTORE is send unconditionally (as it always was),
> > > >
> > > > This is not the right thing, somebody should go over all ATA/ATAPI
> > > > drafts and come with the correct strategy of handling WIN_RESTORE.
> > >
> > > Ok that would make sense. Matthew Garrett also reported some problems in
> > > that area with suspend/resume (BIOS restoring its idea of things...)
> > 
> > Quite likely, WIN_RESTORE is not sent on resume etc.
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

