Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULZQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULZQES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbULZQES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:04:18 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:60355 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261691AbULZQEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:04:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 11:04:06 -0500
User-Agent: KMail/1.7
Cc: Nick Warne <nick@linicks.net>
References: <200412260917.38717.nick@linicks.net> <20041226132047.6ac71b4f@hotline4.alkar.net> <200412261136.18751.nick@linicks.net>
In-Reply-To: <200412261136.18751.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261104.07040.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.45.252] at Sun, 26 Dec 2004 10:04:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 06:36, Nick Warne wrote:
>On Sunday 26 December 2004 11:20, Roman Ivanchukov wrote:
>
>Strange - really strange.  I was specific on that line as that is
> what GCC told me error was - and it was here.
>
>> I've just downloaded linux-2.6.10.tar.bz2 from kernel.org and
>> there is no such error in netfilter.h:
>>
>> /* Call setsockopt() */
>> int nf_setsockopt(struct sock *sk, int pf, int optval, char __user
>> *opt, int len);
>
>I just DL'ed the tar.gz - that is OK.
>
>The image build I done (using oldconfig) booted, but wouldn't mount
> disks, and a few other errors (like looking for modules - I don't
> build with modules).
>
>What on earth could cause that then?  Corrupt download?  I would
> have thought nigh on impossible to get one or two errors like that
> if so?
>
>Nick

The only problem I've had was the one I posted about earlier, 
something locked up amandad and this server didn't get backed up till 
I rebooted & reran amdump about 4ish this morning.  That was after 
about 29 hrs uptime.  It also claimed that a samba share I had 
mounted was busy(but that machine had been powered down for the 
night), and kpm was complaining about a lack of a dcopserver so it 
couldn't connect to the system to monitor anything.  htop worked as 
expected though.  Now I'm waiting for the other shoe to drop.  If it 
does, I'll go back to Ingo's last realtime-preempt patch.  That was 
solid, & had an 8 day uptime when I rebooted to 2.6.10.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
