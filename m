Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSCLXJn>; Tue, 12 Mar 2002 18:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSCLXIv>; Tue, 12 Mar 2002 18:08:51 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:13064 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S287862AbSCLXIp>;
	Tue, 12 Mar 2002 18:08:45 -0500
Date: Tue, 12 Mar 2002 17:31:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@ucw.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020312163156.GB1747@elf.ucw.cz>
In-Reply-To: <20020310202745.GB173@elf.ucw.cz> <Pine.LNX.4.44L.0203111808550.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203111808550.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The problem I find is that I often want to take (file1+patch) -> file2,
> > > > when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
> > > > I haven't seen a graphical tool which helps you to wiggle a patch into
> > > > a file.
> 
> > > I often run "patch" and it drops some chunk because it doesn't match,
> > > and it turns out that the miss-match is just one or two lines in a
> > > chunk that could be very big.
> 
> > Yes, this would be [: very very :] nice.
> 
> Have you people heard about this thing called "branches" ?
> 
> - You keep your own code in your own branch.
> 
> - You keep Linus's code in a linus branch.
> 
> - The patches from Linus always apply to the linus branch.
> 
> - You pull Linus's latest updates into your own branch for
>   development work, at this point you may need to do some
>   merging.  Some SCM systems are horrible at merging (CVS)
>   while others are really nice (BK).

Description above was basically how to do the merging. Oh, and for
people that have just one brach ("my own tree") patch should be quite
sufficient. Having patch more inteligent at rejects would be win for
everyone.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
