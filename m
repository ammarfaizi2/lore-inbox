Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSDHKM5>; Mon, 8 Apr 2002 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312544AbSDHKM4>; Mon, 8 Apr 2002 06:12:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61712 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312410AbSDHKMz>; Mon, 8 Apr 2002 06:12:55 -0400
Date: Mon, 8 Apr 2002 12:12:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Brian Litzinger <brian@top.worldcontrol.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work better
Message-ID: <20020408101256.GE27999@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz> <20020408074729.GA1634@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There were two bugs, and linux/mm.h one took me *very* long to
> > find... Well, those bits used for zone should have been marked. Plus I
> > hack ide_..._suspend code not to panic, and it now seems to
> > work. [Sorry, 2pm, have to get some sleep.]
> 
> I can suspend without oopses.  Yeh!
> 
> However, during the boot '2419p5a3 resume=/dev/hda6'  it oopses right
> after saying a couple of things about not being able to determine
> blocksize.  I'll photograph the repeatable oops and get it to you
> when I have access to my camera again.  Probably in the next
> 24 hours. 

I mailed two patches to the list in last two days. The first one
should fix this.

> > (about SSSCA) "I don't say this lightly.  However, I really think that
> > the U.S. no longer is classifiable as a democracy, but rather as a
> > plutocracy." --hpa
> 
> The US was never a democracy.  It was a constitutional republic.

I think you can have democracy and constitutional republic at same
time, no?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
