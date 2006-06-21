Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWFULjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWFULjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWFULjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:39:37 -0400
Received: from lucidpixels.com ([66.45.37.187]:51433 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750780AbWFULjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:39:36 -0400
Date: Wed, 21 Jun 2006 07:39:35 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: David Greaves <david@dgreaves.com>
cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
In-Reply-To: <449874B6.7020606@dgreaves.com>
Message-ID: <Pine.LNX.4.64.0606210739170.9813@p34.internal.lan>
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
 <4497F1C7.2070007@rtr.ca> <449804EA.8030908@dgreaves.com> <44981800.2000807@dgreaves.com>
 <Pine.LNX.4.64.0606201146430.2601@p34.internal.lan> <449874B6.7020606@dgreaves.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, David Greaves wrote:

> Justin Piszcz wrote:
>> Dave, what is the make/model of the drives you get errors with by the
>> way?
>>
>> On Tue, 20 Jun 2006, David Greaves wrote:
>>> [Some email archaeology later]
>>>
>>> Back in March I was running 2.6.16 (with the opcode patch) and I sent an
>>> email with the following info:
>>>
>>> dmesg:
>>> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
>>> SK/ASC/ASCQ 0xb/00/00
>>> ata1: status=0x51 { DriveReady SeekComplete Error }
>>> ata1: error=0x04 { DriveStatusError }
> Model Family: Maxtor DiamondMax 10 family
> Device Model: Maxtor 6B200M0
> Serial Number: B4038RRH
> Firmware Version: BANC1980
>
> this is sata_sil
>
> Another machine has :
> Device Model: SAMSUNG SP2504C
> Serial Number: S09QJ10Y720963
> Firmware Version: VT100-33
> User Capacity: 250,059,350,016 bytes
>
> running through sata_via
>
> that's running 2.6.16.18 and just gives:
> ata1: PIO error
> ata1: status=0x50 { DriveReady SeekComplete }
>
>
> David
>
> -- 
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

What model SiL? Perhaps the kernel folk could ignore that error on our 
chipset.

0000:02:03.0 RAID bus controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02)

