Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUHXDIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUHXDIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 23:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268403AbUHXDIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 23:08:48 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:60365 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S268399AbUHXDIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 23:08:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Tom Vier <tmv@comcast.net>
Subject: Re: Possible dcache BUG
Date: Mon, 23 Aug 2004 23:08:41 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408220105.25734.gene.heskett@verizon.net> <20040824023418.GD12622@zero>
In-Reply-To: <20040824023418.GD12622@zero>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408232308.41244.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.62.54] at Mon, 23 Aug 2004 22:08:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 22:34, Tom Vier wrote:
>On Sun, Aug 22, 2004 at 01:05:25AM -0400, Gene Heskett wrote:
>> Whereas the error was always at an odd address, and in the 2nd
>> LSbyte, now its still an odd address but the error has moved to
>> the MSB of a 32 bit fetch:
>
>are you translating virt->phys?

No, this is straight out of the memburn output (after I'd fixed the 
printf formatting strings to actually print full 8 character 
hexidecimal, but not the address of the error, thats in decimal)

I don't know enough about this to nail it to a physical address 
unforch.

And right now I have one of the two sticks pulled, trying to figure 
out which one has the tummy ache, but himem is still compiled in and 
cc1plus is going crazy, eating all ram and 500Megs of swap trying to 
build the libsmoke stuff in the new 3.3 kde.  So I'm about to reboot 
to a no himem support kernel since I only have half a Gig with just 
one stick installed, and see if that fixes cc1plus.


Thanks for asking.  I appreciate it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
