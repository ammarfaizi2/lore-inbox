Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVH0ACw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVH0ACw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVH0ACw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:02:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:20150 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030248AbVH0ACw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:02:52 -0400
Date: Fri, 26 Aug 2005 20:02:51 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise ATA/133 Errors With 2.6.10+
In-Reply-To: <20050728223221.7f18a5a4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0508261932240.9925@p34>
References: <Pine.LNX.4.63.0506241653580.31140@p34> <20050728223221.7f18a5a4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that 2.6.13-rc7 has fixed the bug.
I would like to know *What* changed, but I'll probably never find out :(

On Thu, 28 Jul 2005, Andrew Morton wrote:

> Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>>
>> I have two different machines with the 7200.8 Seagate 8MB 400GB drives.
>>
>> Both have ATA/133 controllers, the error is the same on both:
>>
>> Jun 24 15:24:18 localhost kernel: hde: no DRQ after issuing MULTWRITE_EXT
>>
>> I put the drive on an (older) Promise ATA/100 controller = works great!
>> I put the drive on the second box on the motherboard IDE interface = works
>> great!
>>
>> What happened > 2.6.10 to the promise driver?
>>
>> ??
>>
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
> Is this still happening in 2.6.13-rc4?
>
> If so, can you please cc linux-kernel on the reply?  Thanks.
>
