Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSBSUXz>; Tue, 19 Feb 2002 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSBSUVp>; Tue, 19 Feb 2002 15:21:45 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:56330 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289815AbSBSUVa>;
	Tue, 19 Feb 2002 15:21:30 -0500
Date: Tue, 19 Feb 2002 09:25:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tyson D Sawyer <tyson@rwii.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
Message-ID: <20020219092502.A37@toy.ucw.cz>
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com>; from tyson@rwii.com on Sat, Feb 16, 2002 at 10:16:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My system looses about 8 seconds every 20 minutes.  This is reported
> by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
> clock.
> 
> My system is a x86 Dell laptop with HZ=1024.
...
> Since I have defined HZ to be 1024, I miss lots of timer interrupts. 
> However, since the the processor spends 18ms at a time in SMM (System
> Mangement Mode), then even the stock 10ms timer tick will sometimes
> miss a tick.  Thus the problem applies to non-hacked kernels also.

Kernel cancompensate for one lost tick, AFAIR, so go back to HZ=100.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

