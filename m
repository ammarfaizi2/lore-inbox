Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTKUOsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 09:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTKUOsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 09:48:06 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:17339 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262761AbTKUOsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 09:48:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Date: Fri, 21 Nov 2003 09:48:01 -0500
User-Agent: KMail/1.5.1
Cc: iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp> <200311210902.50445.gene.heskett@verizon.net> <200311210925.45366.gene.heskett@verizon.net>
In-Reply-To: <200311210925.45366.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311210948.01512.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Fri, 21 Nov 2003 08:48:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 November 2003 09:25, Gene Heskett wrote:
>On Friday 21 November 2003 09:02, Gene Heskett wrote:
>[...]
>
>>>I had a patch for that.  Maybe it got merged.  You should hunt
>>> down the upstream source and try it out.
>>
>>The srcs for xosview?  I did a freshmeat search, and what I found
>>hadn't been touched in over a year.  I didn't bother grabbing it as
>>it was the same version number as the copy I have.
>
>I must have followed the wrong link, 1.8.1 is building now.

But it won't build the memsat.o module when enabled.  Many pages of 
parse errors if I softlink the newest version number of it to 
memstat.c. Otherwise it cannot find it at all. Not much meat in the 
README's either.  That isn't the one with the newest date however, 
wth?

I'll try without it.

And that, when built, then './xosview' to run it insitu, never shows 
its window, and never shows up in the process table.  A ctrl-c 
returns the prompt instantly.  So I'm not going to install that 
one...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

