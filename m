Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133083AbRDSTsT>; Thu, 19 Apr 2001 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133096AbRDSTsK>; Thu, 19 Apr 2001 15:48:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:51965 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S133083AbRDSTsA>; Thu, 19 Apr 2001 15:48:00 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104191945.f3JJjKRn015661@webber.adilger.int>
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <20010419142400.E10345@sistina.com> "from AJ Lewis at Apr 19, 2001
 02:24:00 pm"
To: linux-lvm@sistina.com
Date: Thu, 19 Apr 2001 13:45:20 -0600 (MDT)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <jes@linuxcare.com>,
        linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AJ Lewis writes:
> On Thu, Apr 19, 2001 at 08:02:50PM +0100, Alan Cox wrote:
> > Well their approach to patches that fix bugs is to reject emails. They've
> > done that to stuff I've reported any many others. So there is a problem.
> > And it's kind of hard to discuss a problem when you are being moderated
> > out of existance.

Not to be negative, but isn't Alan the pot calling the kettle black?  You
use ORBS to block email as well, with no hope of reprieve.  AFAIK, the
linux-lvm list has a moderator which _should_ forward legitimate emails
on to the list.  Maybe they are piling up somewhere, unread?

> Hmm...i guess there is a communication issue here.  It sounds like the
> message that our ML server was sending was misleading.  We were not
> rejecting mail because of content.  The ML server was rejecting it because
> the address was not subscribed.  Our idea was that we don't want spam. 
> If it's completely unmoderated, then we will get a *lot* of spam.

I don't think that the subscription is necessarily the only issue.  I'm
subscribed to all of the LVM mailing lists, and still a lot of what I
submit (legitimate bug fixes, and not just features/code cleanup) does
not get added to CVS.  Yes, the no-possible-harm patches like man pages
went in, but not other stuff.  Also, it doesn't appear that any of the
LVM changes are making it into the stock kernel, which is basically a
recepie for disaster.

Basically, I'm at the point where trying to create clean patches from my
LVM source tree to apply to CVS is so much work it is hardly worth it.
I'm seriously looking at devoting the time I used to spend on LVM to the
EVMS project instead.  They (appear to) have in-kernel LVM support working
already, so no user tools needed for VG/LV activation.  Granted, they don't
yet have tools to create/modify VG/LVs, but I think I can help them there.
It appears more likely that EVMS will only support Linux LVM volumes for
compatibility, and move to a more robust on-disk format for metadata.

The openlvm list may change my mind, I'll see.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
