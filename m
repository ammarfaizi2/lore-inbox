Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRLBSRd>; Sun, 2 Dec 2001 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRLBSRa>; Sun, 2 Dec 2001 13:17:30 -0500
Received: from waste.org ([209.173.204.2]:33430 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S284268AbRLBSRA>;
	Sun, 2 Dec 2001 13:17:00 -0500
Date: Sun, 2 Dec 2001 12:16:47 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <3C0A6539.B650C789@mandrakesoft.com>
Message-ID: <Pine.LNX.4.40.0112021206040.28065-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Jeff Garzik wrote:

> Oliver Xymoron wrote:
> >
> > On Sun, 2 Dec 2001, Alan Cox wrote:
> >
> > > > Please consider the following wipe out candidates as well:
> > > >
> > > > 2. proprietary CD-ROM
> > > > 3. xd.c (ridiculous isn't it?)
> > > > 4. old ide driver...
> > >
> > > I know people using all 3 of those, while bugs in some of the old scsi 8bit
> > > drivers went unnoticed for a year.
> >
> > We need a 'prompt for unmaintained drivers' trailing-edge option in the
> > build process so people will know when something's been orphaned and pick
> > it up.
>
> There's already CONFIG_OBSOLETE...

And it's practically obsolete itself, outside of the ARM directory. What
I'm proposing is something in the Code Maturity menu that's analogous to
EXPERIMENTAL along with a big (UNMAINTAINED) marker next to unmaintained
drivers. Obsolete and unmaintained and deprecated all mean slightly
different things, by the way. So the config option would probably say
'Show obsolete, unmaintained, or deprecated items?' and mark each item
appropriately. Anything that no one made a fuss about by 2.7 would be
candidates for removal.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

