Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293211AbSB1JwY>; Thu, 28 Feb 2002 04:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSB1JuD>; Thu, 28 Feb 2002 04:50:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19471 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293042AbSB1Jr5>; Thu, 28 Feb 2002 04:47:57 -0500
Date: Thu, 28 Feb 2002 10:44:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Patch - sharing RTC timer between kernel and user space
Message-ID: <20020228094453.GA774@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.31.0202242103490.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0202242103490.535-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	it would be really nice to include this patch to allow using of
> RTC timer inside the kernel space. We can use the RTC timer as timing
> source for ALSA sequencer.

I wonder... how does alsa work on sparc/alpha/.... then? Not everyone
has RTC, right? Why don't you use regular kernel timers, instead?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
