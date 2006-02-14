Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWBNXxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWBNXxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBNXxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:53:47 -0500
Received: from lucidpixels.com ([66.45.37.187]:27316 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422870AbWBNXxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:53:46 -0500
Date: Tue, 14 Feb 2006 18:53:45 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
In-Reply-To: <200602141930.45368.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0602141853160.5959@p34>
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602132018290.2607@p34>
 <20060214104345.GM3209@harddisk-recovery.com> <200602141930.45368.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not using anything extravagant and using a 500W aspire PSU, good thought 
though.

On Tue, 14 Feb 2006, Alistair John Strachan wrote:

> On Tuesday 14 February 2006 10:43, Erik Mouw wrote:
>> On Mon, Feb 13, 2006 at 08:18:47PM -0500, Justin Piszcz wrote:
>>> Still get the errors:
>>>
>>> [ 2311.980127] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
>>> 0xb/00/00
>>> [ 2311.980134] ata3: status=0x51 { DriveReady SeekComplete Error }
>>> [ 2311.980138] ata3: error=0x04 { DriveStatusError }
>>
>> FWIW, this could be related to smartctl trying to monitor the disk.
>> Try this:
>>
>>   smartctl -d ata -a /dev/sdX
>>
>> If that complains about SMART being disabled, enable it with:
>>
>>   smartctl -d ata -e /dev/sdX
>
> Are you sure this isn't something obvious like an insufficiently large power
> supply in the system? I've had strange SATA errors before because I was
> running 4 HDs and a 6600GT on a 360W PSU.
>
> -- 
> Cheers,
> Alistair.
>
> 'No sense being pessimistic, it probably wouldn't work anyway.'
> Third year Computer Science undergraduate.
> 1F2 55 South Clerk Street, Edinburgh, UK.
>
