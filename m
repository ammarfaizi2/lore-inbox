Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWBNRM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWBNRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWBNRM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:12:26 -0500
Received: from lucidpixels.com ([66.45.37.187]:21978 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422685AbWBNRMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:12:25 -0500
Date: Tue, 14 Feb 2006 12:12:09 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: David Greaves <david@dgreaves.com>
cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <43F2050B.8020006@dgreaves.com>
Message-ID: <Pine.LNX.4.64.0602141211350.10793@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
 <43F2050B.8020006@dgreaves.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to try the patch too, if available.

I got these errors when nothing (apparent) was going on.

[25158.676998] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[25158.677005] ata3: status=0x51 { DriveReady SeekComplete Error }
[25158.677009] ata3: error=0x04 { DriveStatusError }
[27306.663556] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[27306.663563] ata3: status=0x51 { DriveReady SeekComplete Error }
[27306.663567] ata3: error=0x04 { DriveStatusError }


On Tue, 14 Feb 2006, David Greaves wrote:

> Mark Lord wrote:
>
>> Justin Piszcz wrote:
>> ..
>>
>>>  ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>>>  ata3: status=0x51 { DriveReady SeekComplete Error }
>>>  ata3: error=0x04 { DriveStatusError }
>>
>>
>> I wonder if the FUA logic is inserting cache-flush commands
>> and perhaps the drive is rejecting those?
>>
>> Jeff, we really ought to be including the failed ATA opcode
>> in those error messages!!
>>
> If such a thing were available as a patch then I too would apply it and
> hopefully could provide useful feedback.
>
> David
> PS My problems:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113769509617034&w=2
> http://marc.theaimsgroup.com/?l=linux-ide&m=113828551519727&w=2
> http://marc.theaimsgroup.com/?l=linux-ide&m=113829573105369&w=2
> http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2
>
>
