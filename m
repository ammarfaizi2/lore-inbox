Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUG0WRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUG0WRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUG0WRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:17:50 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:63128 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266661AbUG0WRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:17:47 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 18:17:45 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271442.33208.gene.heskett@verizon.net> <20040727192328.GF12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040727192328.GF12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271817.46050.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.153.92.209] at Tue, 27 Jul 2004 17:17:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 15:23, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
>On Tue, Jul 27, 2004 at 02:42:33PM -0400, Gene Heskett wrote:
>> Humm, I just tried to build it using 2.6.8-rc1 as the main patch
>> to 2.6.7, but then the 2.6.8-rc2-bk3 patch will not apply as the
>> second patch...  I'll go back and redo the rc2 patch first.  Or do
>> I really have something totally fubared?
>
>It goes like that:
>2.6.7
>2.6.7 + 7-bk<n>
>2.6.7 + 8-rc1
>2.6.7 + 8-rc1 + 8-rc1-bk<n>
>2.6.7 + 8-rc2
>2.6.7 + 8-rc2 + 8-rc2-bk<n>
>...
>
>Since rc1 works and rc2 doesnt, you want

I won't go so far as to say if rc1 worked or not, 2 things were going 
on then, first being that rc2 wasn't that far behind rc1, and 2, I'm 
not sure if the nvidia driver in rc1 can do my hardware as I've 
replaced this mobo, all at the samne time.  mobo is now a Biostar 
M7NCD-Pro.  I had some crashes while running rc1, BUT, I also had a 
bad mobo, something in the buss system being overstressed by a 
failing nvidia gforce2 vidio card, which in turn was leading to 
random memory errors.  That wasn't conducive to my pointing any 
fingers at the kernel until I had fixed the hardware probs with new 
hardware.  In any event, I'm now running 2.6.8-rc2-bk3-nf2, the nf2 
to remind me that it no longer has a via ide chipset in it.  And a 
tail -f running on the log in another window :)

I've been outside, making split rail fencing rails the last 3 hours 
while this was running, sweaty stuff.  Then I have to go see a 
genuinely Grand Old Man I've known for 20 years, and who passed this 
weekend, so the evening is half spent before it even gets dark here.  
It'll be beer thirty before I know it after that.  Yes, I'm an 
alcoholic, a 2 beers a night one.  :-)

Thanks for the help, maybe this will tell us something in a day or so.

>	linux-2.6.7.tar.bz2 +
>	testing/patch-2.6.8-rc1.bz2 +
>	snapshots/old/patch-2.6.8-rc1-bk<n>.bz2
>(all under /pub/linux/kernel/v2.6 on ftp.kernel.org and mirrors)

-- 
Cheers Viro, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
