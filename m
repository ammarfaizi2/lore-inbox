Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTKGAvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 19:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTKGAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 19:51:32 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:29330 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262622AbTKGAva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 19:51:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Thu, 6 Nov 2003 19:51:27 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1031106172846.16450A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1031106172846.16450A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061951.27468.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 18:51:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 17:36, Bill Davidsen wrote:
>On Thu, 6 Nov 2003, Gene Heskett wrote:
>> On Thursday 06 November 2003 14:14, bill davidsen wrote:
>> >In article <20031105101207.GI1477@suse.de>, Jens Axboe
>>
>> <axboe@suse.de> wrote:
>> >| k3b is probably still going through ide-scsi which you must
>> >| not. It would be interesting if you could try without ide-scsi
>> >| and use cdrecord manually (maybe someone more knowledgable on
>> >| k3b can common on whether they support 2.6 or not). 2.6 will be
>> >| a lot faster than 2.4.
>> >
>> >I'm not sure what you mean by faster, burning runs at device
>> > limited speed in CPU time in the  less than 1% range if you
>> > remember to enable DMA. The last time I looked DMA didn't work
>> > in either kernel if write size was not a multiple of 1k, (or
>> > 2k?) has that changed?
>> >
>> >I'm not sure what you meant by faster, so don't think I'm
>> > disagreeing with you.
>>
>> As in it actually said it was burning at 12x, and could do a 650
>> meg iso in a bit over 6 minutes including fixating.  Thats about 3
>> to 4 minutes faster than its ever been.
>
>Okay, more or less as expected, 650MB and 380sec (just over six
> minutes) is 10.17x, allowing for OPC and fixating that's about what
> you would expect.
>
>Are you saying that a 12x burn using a 2.4 kernel and ide-scsi
> doesn't take the same time? Because I see ~1.7MB/s if I use
> speed=12 with ide-scsi, and that's as expected (1x = 44100*4/1024
> kB/s). Haven't got a 2.6 system with a burner here, but I do at my
> other site.

Mmm, thats pretty close, Bill.  Maybe its something I just noted the 
last time I tried to burn a disk under ide-scsi, but I caught it 
turning the write speed down to 8x from the 12x setting.  It may have 
been doing that previously without advising me or??  The old times 
were usually just short of 10 minutes.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

