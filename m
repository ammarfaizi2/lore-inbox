Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311869AbSCVKOg>; Fri, 22 Mar 2002 05:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311860AbSCVKOP>; Fri, 22 Mar 2002 05:14:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:43395 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S311869AbSCVKOE>;
	Fri, 22 Mar 2002 05:14:04 -0500
Date: Fri, 22 Mar 2002 10:27:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Blais <blais@iro.umontreal.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Message-ID: <20020322092712.GA233@elf.ucw.cz>
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I actually wanted to implement it exactly like this in xxdiff,
> and I think it may not be too hard. Something like
> 
>   "xxdiff --patch file1 < patch"
> 
> and it would display as two files, and allow you to save merged
> results. That was the plan (read more below).
> 
> I wanted to spawn a patch command on it and recuperate the
> output and then run diff and display that, so one could use and
> alternate patch program as well, and I would reuse patch's
> heuristics automatically (e.g. i don't have to code it myself).

... but ...

> > Neil Brown agreed with this, and said, "I would like a tool
> > (actually an emacs mode) that would show me exactly why a patch
> > fails, and allow me to edit bits until it fits, and then apply
> > it. I assume that is what you mean by "wiggle a patch into a
> > file"." Pavel Machek also thought this would be a rerally great
> > thing.
> 
> The part I haven't figured out a nice solution for yet, is for
> the failed hunks... how to display them sensibly.  I was
> thinking of using the 3-file display with the third file
> showing only the failed hunks in the approximate location where
> they were supposed to be. Not sure how to do this yet. Any
> ideas welcome.

It would be great to somehow split patches before feeding them to the
patch. If you have one big hunk, and it fails because of one letter
added somewhere in file, it is *big pain* to find/kill offending
letter.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
