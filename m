Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSFNR4Z>; Fri, 14 Jun 2002 13:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFNR4Y>; Fri, 14 Jun 2002 13:56:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311749AbSFNR4X>; Fri, 14 Jun 2002 13:56:23 -0400
Date: Fri, 14 Jun 2002 10:56:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <20020614174330.P16772@suse.de>
Message-ID: <Pine.LNX.4.44.0206141051510.11851-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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
> Ditto. As we rapidly approach the 100th incarnation of Martin's IDE
> patches, there are still cases where we die within seconds of booting
> on some old PIO-only boxes for eg.  There seems to be far too much
> "lets rip this out as it doesn't do much anyway" rather than fixing
> known problems.

Are we perhaps forgetting the _point_ of open source?

We're not supposed to be writing code and then releasing it when it is
done. We _want_ incremental changes, and open breakage.

Do bugs happen? Should we expect locking problems if the author is working
on changing the locking (which everybody who has ever looked at the code
admits was totally broken)?

YES.

Am I personally disturbed over the fact that PIO is still totally broken?
Yes. I don't like that part at all, but I do know that Martin is aware of
it, and I keep pushing on him all the time. Martin claims to be on top of
it, and getting close to be able to fix it. I haven't seen any real reason
to doubt him on that so far. We'll get there.

		Linus

