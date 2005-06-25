Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263369AbVFYIfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbVFYIfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 04:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVFYIfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 04:35:33 -0400
Received: from lucidpixels.com ([66.45.37.187]:31416 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S263369AbVFYIfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 04:35:24 -0400
Date: Sat, 25 Jun 2005 04:35:22 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Erik Slagter <erik@slagter.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise ATA/133 Errors With 2.6.10+
In-Reply-To: <1119688191.4293.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0506250435110.32759@p34>
References: <Pine.LNX.4.63.0506241653580.31140@p34>
 <1119688191.4293.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Jun 2005, Erik Slagter wrote:

> On Fri, 2005-06-24 at 16:55 -0400, Justin Piszcz wrote:
>
>> Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
>> Jun 24 15:24:18 localhost kernel: hde: timeout waiting for DMA
>> Jun 24 15:24:18 localhost kernel: hde: status error: status=0x58 {
>> DriveReady SeekComplete DataRequest }
>> Jun 24 15:24:18 localhost kernel:
>> Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
>> Jun 24 15:24:18 localhost kernel: hde: drive not ready for command
>> Jun 24 15:24:18 localhost kernel: hde: status timeout: status=0xd0 { Busy
>> }
>> Jun 24 15:24:18 localhost kernel:
>> Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
>> Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
>> Jun 24 15:24:18 localhost kernel: hde: no DRQ after issuing MULTWRITE_EXT
>> Jun 24 15:24:18 localhost kernel: ide2: reset: success
>
> I have exactly this (these messages) but then with a amd/via ata driver
> on tyan/amd motherboard with an IBM/Hitachi harddisk.
>
> It looks like the drive cpu locks up every now and then, notably when
> the environmental temperature and/or the drive's temperature are high
> and there is much activity on the drive.
>
> A reset (either from the driver or manually using hdparm) helps
> (temporarily).
>
> I was going to buy new drives for this fact (from another brand) but it
> looks that won't necessarily mean my problem will be solved :-(
>
> BTW I have another, exactly identical harddisk in the same computer
> (well, ok, 1 year younger) and that one doesn't show the problem.
>
> BTW2 could it be that somewhere a timeout has been lowered in recent
> kernels? That must have been pre-2.6.11 then.
>

^^

I think so!

The box has worked for the past 6 months and started to have hiccups when
I upgraded it to 2.6.11.x or 2.6.12.x.

