Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbUJ0RIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUJ0RIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUJ0RHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:07:49 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:50595 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262473AbUJ0RFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:05:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 13:05:06 -0400
User-Agent: KMail/1.7
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org
References: <58cb370e04102706074c20d6d7@mail.gmail.com> <200410271215.55472.gene.heskett@verizon.net> <58cb370e04102709221d6a9103@mail.gmail.com>
In-Reply-To: <58cb370e04102709221d6a9103@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271305.06265.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [141.153.91.102] at Wed, 27 Oct 2004 12:05:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 12:22, Bartlomiej Zolnierkiewicz wrote:
>On Wed, 27 Oct 2004 12:15:55 -0400, Gene Heskett
>
><gene.heskett@verizon.net> wrote:
>> On Wednesday 27 October 2004 09:07, Bartlomiej Zolnierkiewicz 
wrote:
>> >Please do a
>> >
>> > bk pull bk://bart.bkbits.net/ide-2.6
>> >
>> >This will update the following files:
>> >
>> > drivers/ide/ide-disk.c         |    1 +
>> > drivers/ide/ide-dma.c          |   32
>>
>> Even after fixing the 4 wrapped lines in the patch, I'm not going
>> in cleanly here:
>>
>> patching file drivers/ide/ide-dma.c
>> Hunk #1 FAILED at 681.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> drivers/ide/ide-dma.c.rej
>>
>> The first 'grep' line of the patch is found at an offset of about
>> +180 lines in the original file.
>>
>> The rest of it seems to have found a home, but at offsets in
>> excess of 159 lines for a few of them.
>>
>> This was against a 2.6.9 tree, and 2.6.9-mm1 failed in similar
>> fashion.  What src tree is this to be applied to?
>
>current linus' -bk tree, latest -bk snapshot should also be OK

Drat.  I can't afford bitkeeper, either the time or the resources.
So I assume this will be in 2.6.10-rc2 or 3?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
