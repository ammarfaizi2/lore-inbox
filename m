Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUHCInA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUHCInA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHCInA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:43:00 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:7849 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S264734AbUHCIm6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:42:58 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.8-rc2-mm2 vs prune_dcache, -mm2 wins (I think)
Date: Tue, 3 Aug 2004 04:42:56 -0400
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408030442.56644.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.12.17] at Tue, 3 Aug 2004 03:42:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I noted there was a patch to fs/dcache.c in -mm2, so I built it.

I may be a bit premature here, but I seem to have made it thru the 4am 
cron driven stuff without a killer Oops from prune_dcache and friends 
such as I have posted several times about (but everyone was at 
conventions)

I had those with 2.6.7, but they were generally not fatal.  Starting 
with 2.6.7-mm1, they generally were fatal to the whole machine, in 
one instance requireing a full powerdown before it would reboot.

>From 2.6.7-mm1 on most of the time it didn't make it to the log, the 
system was gone before the log could be written out.

My uptime:
root@coyote root]# uptime
 04:32:59 up 14:52,  4 users,  load average: 2.55, 2.59, 2.97

Over half a day now!

This seems to be a genuine improvement, many many thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
