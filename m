Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSEVU2a>; Wed, 22 May 2002 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSEVU23>; Wed, 22 May 2002 16:28:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61963 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312411AbSEVU22>; Wed, 22 May 2002 16:28:28 -0400
Date: Wed, 22 May 2002 22:28:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020522202831.GA5551@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020522141306.GB29028@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205220909090.7580-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Its festering quietly in the glibc source tree where all large and
> > > dubiously justifiable hacks seem to end up
> >
> > In such case, linus, here is your "reasonable" example. For PPro, it
> > is faster to copy out-of-order, and if we wanted to use that for
> > copy_to_user, you'd have your example.
> 
> Hey, you didn't read Alan's email.
> 
> The fact that glibc may use it is a strike _against_ your example.
> 
> Have you looked at glibc performance lately?

:-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
