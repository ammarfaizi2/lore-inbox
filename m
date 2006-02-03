Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946103AbWBCXn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946103AbWBCXn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945981AbWBCXn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:43:27 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:37049 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1946103AbWBCXn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:43:26 -0500
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, nigel@suspend2.net,
       suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060203114948.GC2972@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
	 <200602030918.07006.nigel@suspend2.net>
	 <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
	 <20060202171812.49b86721.akpm@osdl.org>
	 <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
	 <20060203114948.GC2972@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 10:43:24 +1100
Message-Id: <1139010204.2191.14.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 12:49 +0100, Pavel Machek wrote:

> > - it is reliable (e.g. I have suspended/resumed mid kernel compile  - 
> > actually, kernel RPM build, which included compile - many times, 
> > without any ill effect)
> 
> Rafael has test patch for this one.

Great. It's been like this for *months* with suspend2.

> > - it is fast (i.e. even on my crappy old HP ZE4201 
> > [http://www.rexursive.com/articles/linuxonhpze4201.html], it writes all 
> > of 700+ MB of RAM to disk just as fast or faster than swsusp).
> 
> Help us with userland parts of uswsusp, pretty please?

Sure, if I find time I will.

> > - it looks nice (both text and GUI interface supported)
> 
> Planned for userland parts.

As I said before - it's going to be years. Never mind that all this
stuff exists in suspend2 now.

> > - it leaves the system responsive on resume (kinda nice to come back to 
> > X and "Just Use it")
> 
> Merged in latest mainline.

Great.

> > - it suspends to both swap and file (I personally use swap, but many 
> > people on the list use file)
> 
> Doable in userland parts; not sure with someone plans it.

Again - stuff is there, but for some weird reason it's not good enough.
Instead of using what's there and works reliably while developing the
next big thing, we'll be back where we were - no decent suspend/resume
support for a while. Excellent.

Whatever happened to release early, release often?

> Can you do usual "try again with minimum drivers" debugging?

Here is the thing - I don't have to do this with suspend2. Why is it
that suspend2 code overcomes the obstacles that swsusp can't? This is
rhetorical, of course.

Anyhow, if I find time, I will.

-- 
Bojan

