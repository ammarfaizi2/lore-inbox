Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUHVLkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUHVLkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUHVLkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:40:47 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:28557 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266657AbUHVLko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:40:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 22 Aug 2004 07:40:42 -0400
User-Agent: KMail/1.6.82
Cc: Helge Hafting <helgehaf@aitel.hist.no>, V13 <v13@priest.com>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408211455.14118.gene.heskett@verizon.net> <20040822110401.GA14172@hh.idb.hist.no>
In-Reply-To: <20040822110401.GA14172@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408220740.42726.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.62.54] at Sun, 22 Aug 2004 06:40:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 August 2004 07:04, Helge Hafting wrote:
>On Sat, Aug 21, 2004 at 02:55:13PM -0400, Gene Heskett wrote:
>> On Saturday 21 August 2004 14:31, V13 wrote:
>>
>> So not only has the problem moved from the 2nd LSB to the MSB of
>> the fetch, but it is a lot more severe in terms of the amount of
>> time to catch one error, now nearly 17 hours.  I'm now up 25 hours
>> and the machine feels good, no Oops so far and I've restarted
>> memburn in addition to konstruct working on kde-3.3 final.  I'm
>> over 100 megs into the swap, and 2.6.8.1-mm2 seems to handling the
>> situation admirably so far.  That knocking sound?  Thats me,
>> knocking on wood for good luck.  :-)
>
>Seems it is the memory, then.
>Things getting *better*�when moving memory may mean:
>* slight timing problem - in that case the memory might be fine
>  at a slower setting.  (Reason for complaints if you must go below
> spec.)

I'd discount this as it made no difference to run it at half speed in 
a bios setting, making a 1400 out of this 2800 athlon at the same 
time the bios signed the ram on as DDR200 dual channel ram.

> * Moving memory around rubs dirt, dust and oxide off the 
> contacts, both on the memory sticks and the mainboard connectors. 
> This gives better contact and may improve things.  Consider
> cleaning the connectors further.  Also look for dust and hair lying
> in the mainboard connectors.  It happens, especially when some
> slots are free for a long time until memory is added.

I think now that this is the scenario in effect.  The next time it 
Oops's, I'll spend some time and reseat both sticks several more 
times.  As this vendor is in Tampa FL, could the storage environment 
there for new mainbooards in their retail packaging box be a factor?  
With the turnover rate Dan has, I wouldn't think so, but then I've 
NDI where they may sit between their assembly in .tw land, and going 
on his shelves in Tampa.  The retail box from Biostar has the board 
in the usual pink bubble-wrap static bag. but it isn't sealed other 
than the end folded over and taped shut.  Ditto for the ram but I 
think thats hand packed per order in the usual grey anti-static, way 
too big, bag.

Right now, memburn hasn't errored again, but konstruct bailed out 
trying to make liboggvorbis, and there is over 830 megs in swap.  I 
should be able to do a swapoff and restart, leaving X/kde, memburn 
and seti running I'd think.  I'll send this and check a swapoff for 
grins.  All this used to run in 512 megs without useing any great 
amount of swap.  :-]

>
>Helge Hafting

Thanks Helge

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
