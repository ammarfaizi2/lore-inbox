Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286300AbRLJQFe>; Mon, 10 Dec 2001 11:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286299AbRLJQFY>; Mon, 10 Dec 2001 11:05:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8979 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286298AbRLJQFJ>; Mon, 10 Dec 2001 11:05:09 -0500
Date: Mon, 10 Dec 2001 17:04:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Clemens <john@deater.net>
Cc: Cory Bell <cory.bell@usa.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011210170405.B24663@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011209131332.A37@toy.ucw.cz> <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > > > know what interrupt is right for maestro3, also on omnibook? ;-).
> 
> I've updated my bios on my Pavilion N5430 and guess what is shows on
> the bios boot screen (if you disable the bios splash screen)... Omnibook
> XE3.  They are one in the same, at least model number wise.  weird,
> considering there are no AMD omnibooks..

I *do* have AMD omnibook on my table.

> > Ouch, you said you have maestro on irq5. And does it *work*? For me,
> > it plays mp3 but repeats portions even on wrong interrupt.
> 
> My maestro is on IRQ 5, and the pIRQ table says it should be on IRQ 5, and
> it works fine. Earlier 2.4 kernels (before .8 or .9) had all sorts of
> problems with the maestro3 (actually Allegro-1), but i haven't had any
> problems in a while.. Try ALSA, see if that fixes your problems.

Interrupts are not comming. If I hook it on irq11 (usb), and make usb
generate interrupts, it plays.

> > > apply to both. If you want to help get the BIOS updated (the root cause,
> > > IMHO), please call HP support and reference case number 1429683616 (that
> > > 9 may be a 4 - my handwriting is horrible). That's the case I logged
> > > with thim about the broken PIR table (USB irq showing 9; being 11) and
> > > failure to enable sse on athlon 4/duron/xp chips.
> 
> Good luck.. I emailed HP support, and got the "we're forwarding your
> request to the BIOS people".. and that was 4 months ago.
> 
> Ohh, and Marcelo accepted the K7/SSE patch for 2.4.17, so no need for that
> patch anymore..

I do not much care about sse, but I'd prefer my sound working :-(.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
