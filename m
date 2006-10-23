Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWJWAzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWJWAzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWJWAzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:55:49 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:62606 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751018AbWJWAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:55:49 -0400
Date: Sun, 22 Oct 2006 20:55:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
In-reply-to: <87r6x09y7j.fsf@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, Adrian Bunk <bunk@stusta.de>
Message-id: <200610222055.23104.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <200610221046.51464.gene.heskett@verizon.net> <87r6x09y7j.fsf@sycorax.lbl.gov>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 11:17, Alex Romosan wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> On Sunday 22 October 2006 08:23, Adrian Bunk wrote:
>>>This email lists some known unfixed regressions in 2.6.19-rc2 compared
>>>to 2.6.18 that are not yet fixed Linus' tree.
>>
>> [...]
>>
>>>Subject    : unable to rip cd
>>>References : http://lkml.org/lkml/2006/10/13/100
>>>Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
>>>Status     : unknown
>>
>> FWIW Alex, I just ripped track 2 of a Trace Adkins CD using grip and
>> cdparanoia, then listened to the track in mplayer, while running
>> 2.6.19-rc2.  No problem at all.  This is however, an older FC2 system,
>> so I'd be inclined to point the finger at cdparanoia's latest version. 
>> Mine hasn't been updated for quite a while.  I have these installed:
>>
>> cdparanoia-alpha9.8-20.1
>> cdparanoia-libs-alpha9.8-20.1
>> cdparanoia-devel-alpha9.8-20.1
>
>the system doesn't lock up all the time, but every time i start ripping
>i get this in syslog:
>
>Oct 22 08:08:16 trinculo kernel: hdc: write_intr: wrong transfer
> direction!
>
>which didn't use to happen before 2.6.19-rc2 (the lockups did).
>anyway, i just gave it another try, grip wasn't able to rip the cd but
>i was able to eject the cd from the drive and then abort execution. i
>am using cdparanoia that came with grip, and this is a very old
>version (2.96, the last before they switched to gnome). i also tried
>with the recent version of cdparanoia but the same thing happens.
>
My grip is a bit newer than that, 3.20 I believe.

>--alex--

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
