Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVCXEuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVCXEuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVCXEty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:49:54 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:3258 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S263031AbVCXEto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:49:44 -0500
Date: Wed, 23 Mar 2005 23:49:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050321174507.6113be4e.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200503232349.42580.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <200503212033.59753.gene.heskett@verizon.net>
 <20050321174507.6113be4e.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 20:45, Andrew Morton wrote:
[...]
>> Lemme see if I've grabbed that patch, brb.  No, but I'll go get it
>> right now.  Got it.  Edited my two scripts and its building now.

After 2 days of running rc1-mm1, I've reverted to plain rc1, for one 
reason.  The last 2 days, its taken amdump/amverify till after 5am to 
finish, and its only done 2, instead of 3, units of setiathome, which 
is now shareing time with the einstein boinc project.

Running plain rc1, the amdump/amverify run was commonly done by a bit 
after 2am, starting at 1am, and seti was getting enough time to do 3 
units all the time. So an hour to hour & 45 max, to over 4 hours is 
the comparison there.

Note that we're talking mm1 here, not the mm2 in the subject line as 
it wasn't visible when I went after the patch at kernel.org. And 
there still is not an -mm2 there, so I assume that was a typu.

So while -mm1 didn't crash, and in fact was quite frugal with its 
memory use, so I haven't had the oom crashes some have reported.  It 
just isn't as fast by a noticable amount.

And I have no idea where to point fingers.  Running kino, there were 
many noticable instances of its video import being hung for at least 
a second at a time, something I haven't noticed with rc1 to anything 
near that extent.  A night and day difference, showstopper to usable  
there.

tvtime also had many more few stutters & skipped frames.  In either 
case, I'd often have to restart tvtime with the new settings to get 
decent audio, so there is no change there.

Scheduler?  DarnedifIknow.  All I could see was the canary getting 
sick, sorry. :(

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
