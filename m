Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314244AbSDVQJn>; Mon, 22 Apr 2002 12:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314258AbSDVQJm>; Mon, 22 Apr 2002 12:09:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39566 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314244AbSDVQJk>;
	Mon, 22 Apr 2002 12:09:40 -0400
Date: Sun, 21 Apr 2002 18:00:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: davidm@hpl.hp.com
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020421180021.A155@toy.ucw.cz>
In-Reply-To: <15548.22093.57788.557129@napali.hpl.hp.com> <Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com> <15548.50859.169392.857907@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   Davide> i still have pieces of paper on my desk about tests done on
>   Davide> my dual piii where by hacking HZ to 1000 the kernel build
>   Davide> time went from an average of 2min:30sec to an average
>   Davide> 2min:43sec. that is pretty close to 10%
> 
> The last time I measured timer tick overhead on ia64 it was well below
> 1% of overhead.  I don't really like using kernel builds as a
> benchmark, because there are far too many variables for the results to
> have any long-term or cross-platform value.  But since it's popular, I
> did measure it quickly on a relatively slow (old) Itanium box: with
> 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> (2.4.18 UP kernel).

.5% still looks like a lot to me. Good compiler optimization is .5% on 
average...

And think what it does with old 386sx.. Maybe time for those "tick on demand"
patches?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

