Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRLVWas>; Sat, 22 Dec 2001 17:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRLVWaj>; Sat, 22 Dec 2001 17:30:39 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:29457 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S282912AbRLVWa0>;
	Sat, 22 Dec 2001 17:30:26 -0500
Date: Sat, 22 Dec 2001 21:54:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@tech9.net>
Cc: Martin Devera <devik@cdi.cz>, Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
Message-ID: <20011222215457.A118@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008792213.806.36.camel@phantasy>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It is interesting that 2.2 can be done with -O. Also I'd expect
> > errors during compilation and not silent crash...
> 
> Well, you certainly won't get errors, because compiler optimizations
> shouldn't change expected syntax.
> 
> -O2 is the standard optimization level for the kernel; everything is
> compiled via it.  When developers test their code, nuances that the
> optimization introduce are accepted.  Removing the optimization may
> break those expectations.  Thus the kernel requires it.

Huh? Those expectations are *bugs*.

Kernel will not link without optimalizations because it *needs*
inlining. Any else dependency is a *bug*.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
