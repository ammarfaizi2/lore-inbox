Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTK0RQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 12:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbTK0RQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 12:16:45 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:40873 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S264557AbTK0RQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 12:16:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Thu, 27 Nov 2003 12:16:40 -0500
User-Agent: KMail/1.5.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311270505.50242.gene.heskett@verizon.net> <20031127133929.GX8039@holomorphy.com>
In-Reply-To: <20031127133929.GX8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271216.40829.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 11:16:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 08:39, William Lee Irwin III wrote:
>On Thu, Nov 27, 2003 at 05:05:50AM -0500, Gene Heskett wrote:
>> My $0.02, but performance like that would scare a new user right
>> back to winderz.
>> Around here, its thanksgiving day, and we traditionally eat way
>> too much turkey (or something like that :)  And then complain
>> about the weight we've gained of course...
>
>This isn't a performance problem. This is a bug. It vaguely sounds
> like a missed wakeup or missing setting of TIF_NEED_RESCHED, but
> could be a number of other things too.
>
>(The missing setting of TIF_NEED_RESCHED theory is right if it's
>possible to clean up after it by ignoring need_resched() in the
>scheduler and always rescheduling.)

Well, running 2.6.0-test11, I just discovered I'm back to being unable 
to 'su amanda' again.  It worked the first time, but I got rejected 
frorm unpacking the lastest amanda-2.4.4p1-20031126.tar.gz due to a 
lack of permissions, so I exited, chowned the archive to what it was 
supposed to be, but cannot now do another su amanda in order to start 
the install of this latest snapshot.

The process just hangs, never comeing back to a prompt.  I never had 
any troubles with that useing test9, so I guess its reboot time 
again.

However, IMO this is a major problem, and needs fixed before 2.6.0.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

