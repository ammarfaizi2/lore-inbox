Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSFNQJx>; Fri, 14 Jun 2002 12:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSFNQJw>; Fri, 14 Jun 2002 12:09:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32239 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317947AbSFNQJv>; Fri, 14 Jun 2002 12:09:51 -0400
Date: Fri, 14 Jun 2002 18:09:28 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <20020614115634.B22888@redhat.com>
Message-ID: <Pine.SOL.4.30.0206141806560.7326-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can just copy old drives/ide/ + include/linux/[ide.h, hdreg.h]
+ asm/ide.h and it should compile/work?...

On Fri, 14 Jun 2002, Benjamin LaHaise wrote:

> On Fri, Jun 14, 2002 at 05:17:03PM +0200, Jens Axboe wrote:
> > And finally a small plea for more testing. Do you even test before
> > blindly sending patches off to Linus?! Sometimes just watching how
> > quickly these big patches appears makes it impossible that they have
> > gotten any kind of testing other than the 'hey it compiles', which I
> > think it just way too little for something that could possible screw
> > peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
> > currently. The success ratio of posted over working patches is too big.
>
> Add my voice to these concerns.  At the very least the code should have
> been moved into a second tree to allow people to work with the old stable
> driver as needed.
>
> 		-ben
> --
> "You will be reincarnated as a toad; and you will be much happier."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

