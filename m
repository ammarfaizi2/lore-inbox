Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUIDPr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUIDPr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 11:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUIDPr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 11:47:57 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:5369 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261875AbUIDPrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 11:47:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
Date: Sat, 4 Sep 2004 11:47:35 -0400
User-Agent: KMail/1.7
Cc: Dave Airlie <airlied@linux.ie>, Arjan van de Ven <arjanv@redhat.com>
References: <Pine.LNX.4.58.0409041053450.25475@skynet> <20040904103711.GD5313@devserv.devel.redhat.com> <Pine.LNX.4.58.0409041418450.25475@skynet>
In-Reply-To: <Pine.LNX.4.58.0409041418450.25475@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041147.35522.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.92.228] at Sat, 4 Sep 2004 10:47:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 September 2004 09:23, Dave Airlie wrote:
>Okay here is an updated patch:
>
>I've taken suggestions from Christoph and Arjan on board,
>
>My only issue is with the stuff in drm_os_linux.h, I've had to make
> a dummy AGP structure, and add the mtrr_add/mtrr_del stubs (as they
> are fine on x86 but don't exist on anything else..) but perhaps a
> small ugly in there is better than big uglies elsewhere...
>
>I might be able to drop the OS_HAS_AGP from the drivers, but that'll
> be a job that requires testing via CVS (as that is where we have
> the people with the different cards..)
>
>Dave.

Having followed this discussion a bit without really understanding it, 
I'd like to make a commment.

I was over to the x.org site this morning, looking to see if I could 
dl the latest tag to see if it would speed up my Extacy(ATI radeon) 
9200SE w/128 MB of memory any.  Tuxracer is a 2 seconds per frame 
game now, and of course unplayable.  And requires a reboot to restore 
x when you *have* managed to quit it, quite a feat in itself 
considering the mouse updates are equally slow, and apparently being 
'smoothed', meaning multiple frame lags after the mouse has been 
stopped.

Unforch, it appears not to be available as a tarball, or group of 
tarballs stuffed in a "grab all these" directory.  While I probably 
wouldn't be anything but a src of distracting questions, I still 
wouldn't mind an opportunity to build and test (and report on the 
grins and scowls) this if it can be built in a sandbox, leaving the 
existing X.org-6.7 release intact for rescue recovery.  I have the 
disk space, and plenty of cpu cycles I can steal from setiathome, so 
thats not a major problem.

Is the present, developers only access intended, or am I a dummy that 
can't see a link if it bit me?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.25% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
