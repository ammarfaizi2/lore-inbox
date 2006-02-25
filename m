Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWBYP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWBYP6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWBYP6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:58:39 -0500
Received: from lucidpixels.com ([66.45.37.187]:41152 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932433AbWBYP6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:58:38 -0500
Date: Sat, 25 Feb 2006 10:58:34 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <44007892.9090002@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602251058110.30688@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <Pine.LNX.4.64.0602231838420.3374@p34> <44007892.9090002@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is patched, if you did not get what you wanted maybe the patch 
does not work in some instances or there is a bug?

On Sat, 25 Feb 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> I have reproduced the error with the patched kernel!
>> 
>> Here it is:
>> 
>> [263864.109854] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
>> 0xb/00/00
>> [263864.109861] ata3: status=0x51 { DriveReady SeekComplete Error }
>> [263864.109866] ata3: error=0x04 { DriveStatusError }
>
> Nope.. patch not present, as otherwise the line above would have
> read something like this:
>
>> [263864.109854] ata3: translated op=0x21 ATA stat/err 0x51/04 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
>
> So we didn't get the extra info since the patch wasn't present.
>
> Cheers
>
