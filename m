Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSBVBD1>; Thu, 21 Feb 2002 20:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSBVBDS>; Thu, 21 Feb 2002 20:03:18 -0500
Received: from starbug.ugh.net.au ([203.31.238.37]:35852 "EHLO
	starbug.ugh.net.au") by vger.kernel.org with ESMTP
	id <S288936AbSBVBDH>; Thu, 21 Feb 2002 20:03:07 -0500
Date: Fri, 22 Feb 2002 12:03:03 +1100 (EST)
From: David Burrows <snadge@ugh.net.au>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <20020221160228.E5583@suse.de>
Message-ID: <20020222115546.B15623-100000@starbug.ugh.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Dave Jones wrote:
> On Fri, Feb 22, 2002 at 01:53:10AM +1100, David Burrows wrote:
>  > I have a problem where my computer locks up during "Calibrating Delay
>  > Loop..".  I have been using Linux on this same hardware for many years,
>  > and it only started doing this 2 days ago.  It does not seem to matter
>  > what kernel version (2.0, 2.2, 2.4.17) I use or what medium I boot from.
>
>  I had an old Winchip box that did this. Turned out to be a bad SIMM.
>  Try running memtest86 for a while.

I have ran memtest86 all the way through, and shuffled the memory around
(moved them to different slots) and it still crashes in calibrating delay
loop.  FreeBSD and Windows still work.  If I knew how init/main.c worked,
what jiffies are and how they are updated (timer interrupt?), then I would
have some idea of what I'm doing when I step through the BogoMip
calculation code.

Is there some sort of (or can there be) a safety check which tests to see
if the timer is functioning correctly and displays an error message such
as "Timer interrupt is broken, system halted." if it is not.  I don't want
to give up on this hardware yet, ESPECIALLY considering that other
operating systems that I absolutely HATE still continue to work, and my
favourite one doesn't. :(

Thanks again for your time,

David.

