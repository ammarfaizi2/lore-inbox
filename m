Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRLBSVd>; Sun, 2 Dec 2001 13:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLBSVR>; Sun, 2 Dec 2001 13:21:17 -0500
Received: from mail112.mail.bellsouth.net ([205.152.58.52]:45885 "EHLO
	imf12bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284276AbRLBSUT>; Sun, 2 Dec 2001 13:20:19 -0500
Message-ID: <3C0A70DE.65F54283@mandrakesoft.com>
Date: Sun, 02 Dec 2001 13:20:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <Pine.LNX.4.40.0112021206040.28065-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Sun, 2 Dec 2001, Jeff Garzik wrote:
> 
> > Oliver Xymoron wrote:
> > >
> > > On Sun, 2 Dec 2001, Alan Cox wrote:
> > >
> > > > > Please consider the following wipe out candidates as well:
> > > > >
> > > > > 2. proprietary CD-ROM
> > > > > 3. xd.c (ridiculous isn't it?)
> > > > > 4. old ide driver...
> > > >
> > > > I know people using all 3 of those, while bugs in some of the old scsi 8bit
> > > > drivers went unnoticed for a year.
> > >
> > > We need a 'prompt for unmaintained drivers' trailing-edge option in the
> > > build process so people will know when something's been orphaned and pick
> > > it up.
> >
> > There's already CONFIG_OBSOLETE...
> 
> And it's practically obsolete itself, outside of the ARM directory. What
> I'm proposing is something in the Code Maturity menu that's analogous to
> EXPERIMENTAL along with a big (UNMAINTAINED) marker next to unmaintained
> drivers. Obsolete and unmaintained and deprecated all mean slightly
> different things, by the way. So the config option would probably say
> 'Show obsolete, unmaintained, or deprecated items?' and mark each item
> appropriately. Anything that no one made a fuss about by 2.7 would be
> candidates for removal.

The idea behind CONFIG_OBSOLETE is supposed to be that it does not
actually appear as a Y/N option.  You enclose a Config.in option with
that, and it disappears 

But I'm all for removing old stuff.  There is no reason to keep
something that flat out doesn't work and hasn't for a long long time... 
if somebody wants to pick it up they can grab linux-2.2 or linux-2.0
from any FTP mirror.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

