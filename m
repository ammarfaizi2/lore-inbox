Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293130AbSB1JwX>; Thu, 28 Feb 2002 04:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293211AbSB1JuG>; Thu, 28 Feb 2002 04:50:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19983 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293216AbSB1Jr7>; Thu, 28 Feb 2002 04:47:59 -0500
Date: Thu, 28 Feb 2002 10:44:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
Message-ID: <20020228094444.GB750@elf.ucw.cz>
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl> <3C79435E.8030208@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C79435E.8030208@evision-ventures.com>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Pity - noncompressed is better, now only people with too much time
> >will look at it.
> >
> >There is something else one might do.
> >In ide-geometry.c there is the routine probe_cmos_for_drives().
> >Long ago I already wrote "Eventually the entire routine below
> >should be removed". I think this is the proper time to do this.
> >
> >This probe is done only for the i386 architecture, and only
> >for the first two IDE disks, and only influences their geometry.
> >It has been a pain - for example, it gives the first two disks
> >a different geometry from the others, which is inconvenient
> >when one want a RAID of identical disks.
> >
> Basically I lend toward your arguments. I think too that a bios based
> detection is already right and then we have now the ide-skip kernel
> parameter which is allowing to exclude a drive from handling by the 
> linux ide driver anyway. And I think that 2.4.x and above don't run on
> i386's anymore anyway.

I sure hope they do.

I run 2.4.x on 486sx, which is .... pretty close to 386. 386 support
is not going to get dropped anytime soon...
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
