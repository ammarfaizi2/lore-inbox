Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137067AbREKHFo>; Fri, 11 May 2001 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137064AbREKHFf>; Fri, 11 May 2001 03:05:35 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S137063AbREKHFS>;
	Fri, 11 May 2001 03:05:18 -0400
Date: Mon, 7 May 2001 19:04:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010507190437.B45@(none)>
In-Reply-To: <80BTbB7Hw-B@khms.westfalen.de> <13656.988875876@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <13656.988875876@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 03, 2001 at 05:44:36PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On 03 May 2001 09:13:00 +0200, 
> kaih@khms.westfalen.de (Kai Henningsen) wrote:
> >pavel@suse.cz (Pavel Machek)  wrote on 30.04.01 in <20010430104231.C3294@bug.ucw.cz>:
> >
> >> PS: Hmm, how do you do timewarp for just one userland appliation with
> >> this installed?
> >
> >1. What on earth for?
> 
> Y10K testing :)
> 
> >2. How do you do it today, and why wouldn't that work?
> 
> LD_PRELOAD on a library that overrides gettimeofday().  I can see no
> reason why that would not continue to work.  What would stop working
> are timewarp modules that intercepted the syscall at the kernel level
> instead of user space level.

...and would break ptrace too.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

