Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTBLOV2>; Wed, 12 Feb 2003 09:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTBLOV2>; Wed, 12 Feb 2003 09:21:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10503 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267224AbTBLOV0>; Wed, 12 Feb 2003 09:21:26 -0500
Date: Wed, 12 Feb 2003 15:31:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Fix random memory corruption during suspend-to-RAM resume
Message-ID: <20030212143114.GE13327@atrey.karlin.mff.cuni.cz>
References: <20030211111601.GA11817@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302111222250.1405-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302111222250.1405-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hmm.. The stack grows downwards, are you sure you don't really mean
> > > 
> > > 	mov $(wakeup_end-wakeup_code),%sp
> > > 
> > > (because wakeup_end is the end of the wakeup_stack area..)
> > 
> > Yes, I'm sure:
> 
> No. The code is crap. Please send a _fixed_ patch that clearly puts the 
> stack pointer at the _end_ of the stack.
> 
> What you are sure of is that is _happens_ to work by pure luck.
> 
> I'd rather have known-broken code in the kernel than code that works by 
> mistake. The former at least gets fixed.

It should be already in the queue (waiting on my home machine sorry),
along with fix to make it all fit in one page.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
