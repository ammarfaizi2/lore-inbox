Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135768AbRDTApM>; Thu, 19 Apr 2001 20:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135767AbRDTApD>; Thu, 19 Apr 2001 20:45:03 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:7934 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135768AbRDTAou>; Thu, 19 Apr 2001 20:44:50 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104200041.f3K0fdcE016594@webber.adilger.int>
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <20010419145337.K10345@sistina.com> "from AJ Lewis at Apr 19, 2001
 02:53:37 pm"
To: linux-lvm@sistina.com
Date: Thu, 19 Apr 2001 18:41:38 -0600 (MDT)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <jes@linuxcare.com>,
        linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AJ writes:
> Ok, the issue here is that we're trying to get a release out and so anything
> that majorly changes the code is getting shunted aside for the moment.

Actually, the whole idea of "trying to get a release out" is part of the
problem.  If patches were included into CVS and sent sent to Linus as they
arrived we wouldn't be in this situation.  My take on this is that holding
back legitimate patches "to get the release out" ends up accumulating so
many changes that it is impossible to sync up later. The Linux kernel is a
successful project because Linus generally accepts everything that is a 
bug fix or code cleanup (features are another matter, but very little if
any of the patches I send you are "features").

> It would be stupid to just add everything that comes in on the ML without
> review.  Linus does the exact same thing.

Yes, it would be stupid to "just accept everything" that is sent to the
mailing list, but really, I've done a pretty good job of submitting patches
in small, self-contained pieces IMHO (even if it happens that I send a lot
of such patches at one time).  I mean the code has to be cleaned up at some
time, so we may as well do it sooner rather than later.

> I've said this before to you Andreas, but apparently you feel that you
> should have final say on whether your patches go in or not.

Well, I would hope that given the fact I've been working on LVM considerably
longer than anyone else at Sistina (excluding Heinz) that you might just
trust my judgement a bit more.  I'm _trying_ to contribute to LVM, and do
so in easy-to-digest pieces, but given that it is hard to get patches into
CVS, and my codebase is increasingly divergent from your CVS tree.

I have better ways to spend my time than going through 10,000 lines of
diff and guessing which parts are new, and which parts have been held of
"for the next release".  The EVMS code is starting out clean, and I hope
I can help keep it that way.

> As far as getting patches into the stock kernel, we've been sending patches
> to Linus for over a month now, and none of them have made it in.  Maybe
> someone has some pointers on how we get our code past his filters.

That's because the "release" patches are too huge now.  If it were up to me,
and I've asked you a couple of times on this, I would have already sent a
whole bunch of bug fixes to Linus as small, self-contained patches.  However,
I held back because you asked me not to send patches to Linus directly.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
