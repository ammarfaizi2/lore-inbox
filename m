Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUHECQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUHECQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHECQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:16:16 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:2701 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S267361AbUHECQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:16:13 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Wed, 4 Aug 2004 22:16:12 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
In-Reply-To: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408042216.12215.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.11.172] at Wed, 4 Aug 2004 21:16:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 09:14, Brett Charbeneau wrote:
>Greetings,
>
>	I am getting the oops below - twice since 7/26, but I haven't a
>clue what's causing it.
>	I am not a subscriber, so any replies directed to me would be
>gratefully received.
>	Thank you for your hard work on this!

The attachment this gentleman included specifically points to 
prune_dcache().  Thats nice.  It also means I'm not alone.  See the 
'prune_dcache() Oops, the saga continues' thread.

I got in about 9pm after spending the afternoon inside a tv 
transmitter, having left the house about 1ish.  Black screen. 
keyboard leds out.  The usual.  Last log entry was at 14:49 EDT this 
afternoon.  Some file fam couldn't find message.  Whenever it went 
down, it went so fast there was no logged trace.  The next entry is 
syslogd restarting after I'd hit the reset button.

So whatever took it down, did it all by itself as the only non-system 
processes running were setiathome, X and kmail (from kde3.2, 
kde3.2.3, and kde3.3-beta2, makes no diff, all fail in 
prune_dcache() ) making an every 10 minute run to get the mail.

I *thought* I had PREEMPT turned off, but when I did a make xconfig, 
it was turned on.  So its now off, and a new 2.6.8-rc3 is building.
It was frame pointers I had turned on for the last build, still on for 
this one underway now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
