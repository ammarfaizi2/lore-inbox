Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWBCLuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBCLuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWBCLuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:50:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1498 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750715AbWBCLuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:50:01 -0500
Date: Fri, 3 Feb 2006 12:49:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bojan Smojver <bojan@rexursive.com>
Cc: Andrew Morton <akpm@osdl.org>, nigel@suspend2.net,
       suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203114948.GC2972@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <200602030918.07006.nigel@suspend2.net> <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com> <20060202171812.49b86721.akpm@osdl.org> <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just for the record.

> Here is what I prefer in suspend2:
> 
> - it works (i.e. I have compiled it for at least 20 different Rawhide 
> kernels and it always suspended/resumed properly)
> 
> - it is reliable (e.g. I have suspended/resumed mid kernel compile  - 
> actually, kernel RPM build, which included compile - many times, 
> without any ill effect)

Rafael has test patch for this one.

> - it is fast (i.e. even on my crappy old HP ZE4201 
> [http://www.rexursive.com/articles/linuxonhpze4201.html], it writes all 
> of 700+ MB of RAM to disk just as fast or faster than swsusp).

Help us with userland parts of uswsusp, pretty please?

> - it looks nice (both text and GUI interface supported)

Planned for userland parts.

> - it leaves the system responsive on resume (kinda nice to come back to 
> X and "Just Use it")

Merged in latest mainline.

> - it suspends to both swap and file (I personally use swap, but many 
> people on the list use file)

Doable in userland parts; not sure with someone plans it.

> Just today, I tried the most recent Rawhide kernel (based on 
> 2.6.16-rc1-git5) with swsusp and for the first time *ever* it actually 
> returned X to its original state (I was so excited, I even notified 
> people on suspend2 development list about it). But, on second 
> suspend/resume, it promptly locked up my system. Before, it would 
> simply lock up. So, if swsusp can be made to actually work, be 
> reliable, look nice and be responsive on resume, I'm all for it. I will 
> miss Nigel's excellent support though, but I'm sure he deserves a break 
> :-)

Can you do usual "try again with minimum drivers" debugging?
								Pavel
-- 
Thanks, Sharp!
