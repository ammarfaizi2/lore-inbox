Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSAXUlV>; Thu, 24 Jan 2002 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290237AbSAXUlN>; Thu, 24 Jan 2002 15:41:13 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:5896 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290229AbSAXUk6>;
	Thu, 24 Jan 2002 15:40:58 -0500
Date: Wed, 23 Jan 2002 17:37:57 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, "Udo A. Steinberg" <reality@delusion.de>
Subject: Re: [PATCH] Combined APM patch for 2.5.3-pre2
Message-ID: <20020123173757.D78@toy.ucw.cz>
In-Reply-To: <20020121135046.574bfa60.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020121135046.574bfa60.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Mon, Jan 21, 2002 at 01:50:46PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the same patch as the 2.4 combined APM patch I posted earlier,
> but against 2.5.3-pre2.  It does:
> 	Update a couple of email addresses
> 	Fix the idle handling (this is an improved version of the fix
> 		that Alan Cox has in his -ac tree)
> 	Notify user mode of suspend events before drivers (fix)
> 	Make the idling percentage boot time configurable
> 	Rename kapm-idled to kapmd

Why? Leave the name alone. It does not matter, and it changed already too
much in the past. It *is* idle thread!

> Anyone brave enough to run 2.5.3-pre on their laptop, please test
> and let me know the results.

Anyone brave enough is already testing swsusp ;-)))).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

