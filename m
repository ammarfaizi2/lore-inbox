Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRGMUiI>; Fri, 13 Jul 2001 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRGMUh6>; Fri, 13 Jul 2001 16:37:58 -0400
Received: from [194.213.32.142] ([194.213.32.142]:14852 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267009AbRGMUhv>;
	Fri, 13 Jul 2001 16:37:51 -0400
Message-ID: <20010713012417.C122@bug.ucw.cz>
Date: Fri, 13 Jul 2001 01:24:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: swsusp again [was Re: Switching Kernels without Rebooting?]
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org> <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva> <84jaVrwXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <84jaVrwXw-B@khms.westfalen.de>; from Kai Henningsen on Thu, Jul 12, 2001 at 09:23:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What I'd *really* like (but don't see how to get there) would be a "save  
> system state, shutdown, change kernel and/or hardware, reboot, restore  
> state" system (where state is like "I'm logged in on this console, in this  
> current directory, and under X I have Netscape running and this page  
> displayed" but I don't care about the exact state of Squid or even if my  
> ISDN line is dialled in, because those "fix themselves").

Suspend-to-disk, change hardware, restore-from-disk, load neccessary
modules seems quite easy to do with swsusp. It is very different from
suspend-to-disk, change kernel, restore-from-disk (which is guaranteed
to kill you if kernel changes size).

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
