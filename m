Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSLSWIL>; Thu, 19 Dec 2002 17:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWHO>; Thu, 19 Dec 2002 17:07:14 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267173AbSLSWGl>;
	Thu, 19 Dec 2002 17:06:41 -0500
Date: Thu, 19 Dec 2002 00:53:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218235327.GC705@elf.ucw.cz>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It's not as good as a pure user-mode solution using tsc could be, but
> > we've seen the kinds of complexities that has with multi-CPU systems, and
> > they are so painful that I suspect the sysenter approach is a lot more
> > palatable even if it doesn't allow for the absolute best theoretical
> > numbers.
> 
> don't many of the multi-CPU problems with tsc go away because you've got a
> per-cpu physical page for the vsyscall?
> 
> i.e. per-cpu tsc epoch and scaling can be set on that page.

Problem is that cpu's can randomly drift +/- 100 clocks or so... Not
nice at all.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
