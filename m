Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbULaBG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbULaBG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 20:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbULaBG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 20:06:26 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:5323 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261802AbULaBGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 20:06:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac1
Date: Thu, 30 Dec 2004 20:06:19 -0500
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1104103881.16545.2.camel@localhost.localdomain> <200412300005.31211.gene.heskett@verizon.net> <1104430176.2446.3.camel@localhost.localdomain>
In-Reply-To: <1104430176.2446.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412302006.19872.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.52.185] at Thu, 30 Dec 2004 19:06:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 December 2004 18:38, Alan Cox wrote:

Thanks for the reply Alan, I appreciate it.

>On Iau, 2004-12-30 at 05:05, Gene Heskett wrote:
>> some sort of an error message that looks like it may be memory
>> related.  There's a pair of half giggers in here, running at 333
>> fsb, but they are supposedly rated for a 400 mhz fsb. Thats
>> presumably because I have turned on the MCE stuffs.
>
>MCE's generally come from the processor. To decode it you need to
> know what CPU and then get the manuals out and decode the bits.
>
>> Dec 29 23:44:09 coyote kernel: MCE: The hardware reports a non
>> fatal, correctable incident occurred on CPU 0. Dec 29 23:44:09
>> coyote kernel: Bank 2: d40040000000017a
>>
>> And I've not seen that before.  Does it have a simple and correct
>> answer?
>
>Its unhappy about something, but whatever is causing it isn't fatal.
>Previously its been unhappy but not telling you ..

Thats what I thought too Alan, after I'd connected the dots, so I 
turned the nonfatal exceptions off.  I'll give memtest86 another 
chance to break it sometime next week.  This is NOT ecc memory that I 
know of although I paid nearly $80 per half gig when I bought it last 
spring.  Theres a gig of it in here, and only two addresses were 
being reported, one in each bank.  If mapped directly, are those 
addresses even in that gig of ram?  Thats too big a hex number for my 
calculator.  Or is there a way to use the dmesg data to define that?

Dumb question, could this memory be on the video card?  Its an ATI 
9200SE 128 meg card, your basic $85 commodity card there days.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
