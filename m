Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317939AbSFNPnb>; Fri, 14 Jun 2002 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317940AbSFNPna>; Fri, 14 Jun 2002 11:43:30 -0400
Received: from ns.suse.de ([213.95.15.193]:45835 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317939AbSFNPn3>;
	Fri, 14 Jun 2002 11:43:29 -0400
Date: Fri, 14 Jun 2002 17:43:30 +0200
From: Dave Jones <davej@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020614174330.P16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jens Axboe <axboe@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 05:17:03PM +0200, Jens Axboe wrote:

 > And finally a small plea for more testing. Do you even test before
 > blindly sending patches off to Linus?! Sometimes just watching how
 > quickly these big patches appears makes it impossible that they have
 > gotten any kind of testing other than the 'hey it compiles', which I
 > think it just way too little for something that could possible screw
 > peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
 > currently. The success ratio of posted over working patches is too big.

Ditto. As we rapidly approach the 100th incarnation of Martin's IDE
patches, there are still cases where we die within seconds of booting
on some old PIO-only boxes for eg.  There seems to be far too much
"lets rip this out as it doesn't do much anyway" rather than fixing
known problems.

When the IDE carnage first started back circa 2.5.3, I had contemplated
not merging *any* of the IDE patches, just so that people who want to
work on other areas could have something solid to build upon.
I regret not following through on that instinct.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
