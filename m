Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGHA2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGHA2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWGHA2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:28:22 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:1973 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S932447AbWGHA2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:28:22 -0400
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
In-Reply-To: <20060707232523.GC1746@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <44A14D3D.8060003@wasp.net.au>
	 <20060627154130.GA31351@rhlx01.fht-esslingen.de>
	 <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com>
	 <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com>
	 <20060707180310.ef7186d7.grundig@teleline.es>
	 <20060707174424.GA9913@dspnet.fr.eu.org> <20060707213916.GC5393@ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 10:28:14 +1000
Message-Id: <1152318494.15651.11.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 01:25 +0200, Pavel Machek wrote:

> You can either use suspend2 (14000 lines of unreviewed kernel code,
> old) or uswsusp (~500 lines of reviewed kernel code, ~2000 lines of
> unreviewed userspace code, new).
> 
> Of course, you can also use swsusp (~2000 lines of reviewed kernel
> code, pretty old) if stability matters to you more than graphical
> progress bar.

I've been using Suspend2 on my notebook for a long, long time now and
the code is not unstable. In fact, I never reboot my system unless there
is a kernel upgrade from Fedora. And I do suspend/resume many times
every day, sometimes on AC power, sometimes on battery. And I never lost
one bit of information on my file system as a result of Suspend2 stuff
up.

Also, Suspend2 can do many things that neither swsusp or even uswsusp
can do, like suspending to regular files, swap files or combination of
swap, swapfiles and regular files. It is also *much* faster than swsusp,
to the point that it takes less time to resume *full* image of memory
with Suspend2 than it takes half memory with swsusp. It easy to confuse
people by comparing apples and oranges, so let's not do that.

So, the code may be "unreviewed", but it is sure field tested. And by
many, not just me.

-- 
Bojan

