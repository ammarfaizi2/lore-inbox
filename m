Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVCEXek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVCEXek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVCEXdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:33:02 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:14784 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261225AbVCEX0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:26:08 -0500
Date: Sat, 05 Mar 2005 18:26:01 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.11.1
In-reply-to: <1110060362.12513.48.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051826.01437.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050304175302.GA29289@kroah.com>
 <200503051649.58709.gene.heskett@verizon.net>
 <1110060362.12513.48.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 17:06, Lee Revell wrote:
>On Sat, 2005-03-05 at 16:49 -0500, Gene Heskett wrote:
>> What he said!  Perfectly good patches, which fix real problems
>> would appear to be sitting in testing/broken_out till bit rot or
>> ???.
>>
>> If you want a testers testimony, I'm running the
>> bk-ieee1394.patch, and all I can say at this point is that it Just
>> Works(TM).  I have NDI how it got a yesterdays Mar 4) date in the
>> directory listing there though, I've had it a bit longer than that
>> by 2-3 days as my copy shows a Mar 1 date.  I first got it via svn
>> fetch at linux-ieee1394.org or some such in January.
>>
>> Fixes for real problems that fix real problems should somehow get
>> a faster track into final.  The current firewire in the kernel as
>> of 2.6.11 is still badly borked.
>
>Driver updates are a hard problem.  Nothing annoys users more than
>unsupported hardware.  But if you aggressively add support for new
>devices you can break things that have worked for ages.
>
>A change that makes your hardware work may break someone else's. 
> There is no such thing as an obviously correct patch when you are
> flipping bits in the hardware.  You can never eliminate 100% of
> driver regressions, all you can do is minimize the impact by
> getting release candidates tested on the widest possible range of
> hardware.
>
>Lee

True up to a certain extent, Lee.  I did not own any firewire stuff 
except for a 6 year old firewire card I didn't have anything to plug 
into, a TI of some sort that supposedly needed the ti-linx driver,  
until I bought this camera.  That card quickly proved to be borked 
per comments made on the linux-firewire list, and got replaced with a 
$25 belkin card from wallyworld.  One buys whats available at your 
friendly local wallyworld as a first pass at fixing things.  That 
worked great when it felt like it, which wasn't often.  Now, with 
this patch, it Just Works(TM).

My point is that if it doesn't get into mainline, how are you going to 
know it it breaks something that formerly worked?  In my case, it 
certainly fixed something that didn't work, and didn't break anything 
that I know of *yet*.

I have quite a managerie of accessories hanging off of the various 
ports, mostly usb on this box, and I have a regular tour of them I 
make when I reboot to a newer kernel, so if something breaks sane, or 
printing, networking, x10, what have you, I usually know about it 
within 30 minutes of the reboot.

Frankly, I was surprised that this elcheapo belkin card worked so 
good!  Their bigger ups's, and this card seem to be the exception to 
the mainline and very prominent story of all their broken KVM 
switches.  A pleasant surprise in light of my reticence to even put 
fingerprints on many of the belkin boxes on the shelf at Staples et 
all.

However, that doesn't address the fact that the patch I grabbed, dated 
Mar 1, is apparently older than the one in testing/broken_out dated 
Mar 4.  Both are 265824 bytes long however, so I'm going to go with 
the theory that someone rebuilt the directory on kernel.org.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
