Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbULYAmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbULYAmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 19:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULYAmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 19:42:43 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:16795 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261468AbULYAmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 19:42:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 xfs segfault on boot startup?
Date: Fri, 24 Dec 2004 19:42:36 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412241942.36264.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.45.252] at Fri, 24 Dec 2004 18:42:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I just rebooted to a "still got that new car smell" fresh 2.6.10, and 
this went by on the boot screen while it was starting the various 
services in init.d:

Starting xfs: /etc/rc3.d/S90xfs: line 137:  2377 Segmentation fault      
ttmkfdir -d . -o fonts.scale
/etc/rc3.d/S90xfs: line 137:  2404 Segmentation fault      ttmkfdir 
-d . -o fonts.scale

I had installed some new ttf fonts over the last day or so, and had 
used them with the beta OOo-1.9-xxx before rebooting from 
2.6.10-V0.33-04, but when I did a 'service xfs restart' just before 
seeing if startx worked (it did obviousy) no further errors were 
output, and it was running when I did that, so its apparently not 
repeatable.

But it was a bit puzzling.  Anybody have an idea?  Self-healing 
software, the Holy Grail...

Merry Christmas wishes to all that celebrate it on this list.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
