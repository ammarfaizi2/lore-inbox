Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUIWDIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUIWDIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUIWDIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:08:50 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:62180 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S268175AbUIWDIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:08:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2 vs cachefs
Date: Wed, 22 Sep 2004 23:08:42 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409222308.42860.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.51.220] at Wed, 22 Sep 2004 22:08:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just now rebooted to 2.6.9-rc2-mm2 after making an unrelated 
adjustment to my modprobe.conf, trying to get the pl2303 module to 
autoload on boot.  That didn't work either, but I can modprobe it in 
by hand and that seems to do it.

But as it was rebooting, I saw this go by in my dmesg:

CacheFS: Wrong magic number on cache

and there appears to be no further references to it.

I don't recall seeing that msg before now, and it has been turned on 
in the kernels I'm building for quite a while.  I probably haven't 
properly init'd it or something equally dumb as I don't think there 
is a line in my /etc/fstab for it.  So what should that line look 
like from a copy/paste from somebody elses /etc/fstab that has it 
working?

Humm, I just read Documentation/cachefs.txt, and I see it wasn't what 
I had in mind from the description at all.  And rather than try and 
setup all that, I think I might take it back out of the kernel here 
unless someone can show a good example of how to use it, to take the 
pressure off of /swap for instance.  Or could it even be made to do 
that?

TIA

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
