Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUK3EyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUK3EyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUK3EyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:54:04 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:11491 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261980AbUK3Ex6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:53:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
Date: Mon, 29 Nov 2004 23:54:05 -0500
User-Agent: KMail/1.7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411291816.43591.gene.heskett@verizon.net> <41ABD1CE.1010004@cybsft.com>
In-Reply-To: <41ABD1CE.1010004@cybsft.com>
Cc: "K.R. Foley" <kr@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411292354.05995.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.42.91] at Mon, 29 Nov 2004 22:53:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 20:50, K.R. Foley wrote:
>Gene Heskett wrote:

>>>make that -31-13 (or later). Earlier kernels had a bug in where

[...]

>Is this all that is in the log? For some reason there are 820
> samples not represented in the output above. The ms+ hits would
> have been represented by something like:
>
>Nov 29 18:05:45 coyote kernel: 9999 4

Ok, I finally got -13 to run (typo in grub), and you are now correct 
in that the final entry in the log after I shut tvtime down is like 
this:

Nov 29 23:43:40 coyote kernel: rtc latency histogram of {tvtime/3911, 
10430 samples}:
Nov 29 23:43:40 coyote kernel: 4 51
Nov 29 23:43:40 coyote kernel: 5 2058
Nov 29 23:43:40 coyote kernel: 6 3594
Nov 29 23:43:40 coyote kernel: 7 1270
Nov 29 23:43:40 coyote kernel: 8 473
Nov 29 23:43:40 coyote kernel: 9 299
Nov 29 23:43:40 coyote kernel: 10 252
Nov 29 23:43:40 coyote kernel: 11 209
Nov 29 23:43:40 coyote kernel: 12 215
Nov 29 23:43:40 coyote kernel: 13 345
Nov 29 23:43:40 coyote kernel: 14 391
Nov 29 23:43:40 coyote kernel: 15 248
Nov 29 23:43:40 coyote kernel: 16 113
Nov 29 23:43:40 coyote kernel: 17 55
Nov 29 23:43:40 coyote kernel: 18 17
Nov 29 23:43:40 coyote kernel: 19 11
Nov 29 23:43:40 coyote kernel: 20 4
Nov 29 23:43:40 coyote kernel: 21 1
Nov 29 23:43:40 coyote kernel: 23 2
Nov 29 23:43:40 coyote kernel: 28 1
Nov 29 23:43:40 coyote kernel: 4612 1
Nov 29 23:43:40 coyote kernel: 9999 820

What does this tell you now?  The last 2 lines look a bit strange to
me.  Particularly since the runtime was random enough that your 
previous comment about the number 820 was a mssing count, and what 
came out of a seperate run IS an 820.

I find that a bit hard to believe that I timed those two runs 
identically.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
