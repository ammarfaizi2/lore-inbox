Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSFNQGd>; Fri, 14 Jun 2002 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSFNQGc>; Fri, 14 Jun 2002 12:06:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19438 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317945AbSFNQG3>; Fri, 14 Jun 2002 12:06:29 -0400
Date: Fri, 14 Jun 2002 18:06:17 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dave Jones <davej@suse.de>
cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <20020614174330.P16772@suse.de>
Message-ID: <Pine.SOL.4.30.0206141758350.7326-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just my 0.02 plns...

On Fri, 14 Jun 2002, Dave Jones wrote:

> On Fri, Jun 14, 2002 at 05:17:03PM +0200, Jens Axboe wrote:
>
>  > And finally a small plea for more testing. Do you even test before
>  > blindly sending patches off to Linus?! Sometimes just watching how
>  > quickly these big patches appears makes it impossible that they have
>  > gotten any kind of testing other than the 'hey it compiles', which I
>  > think it just way too little for something that could possible screw
>  > peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
>  > currently. The success ratio of posted over working patches is too big.
>

I review every single patch from Martin and they are usually ok,
but it is generally good habbit to wait for next patch before running
previous one (just to see if there was any bugs in previous one)...

> Ditto. As we rapidly approach the 100th incarnation of Martin's IDE
> patches, there are still cases where we die within seconds of booting
> on some old PIO-only boxes for eg.  There seems to be far too much
> "lets rip this out as it doesn't do much anyway" rather than fixing
> known problems.

I will try to fix them one by one soon...

>
> When the IDE carnage first started back circa 2.5.3, I had contemplated
> not merging *any* of the IDE patches, just so that people who want to
> work on other areas could have something solid to build upon.
> I regret not following through on that instinct.
>

Your mistake, Dave ;)

>         Dave.
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -

--
Bartlomiej

