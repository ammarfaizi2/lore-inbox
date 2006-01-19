Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161418AbWASUrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161418AbWASUrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbWASUrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:47:14 -0500
Received: from host233.omnispring.com ([69.44.168.233]:35809 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1161418AbWASUrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:47:14 -0500
Message-ID: <43CFFAB8.2090104@cfl.rr.com>
Date: Thu, 19 Jan 2006 15:46:48 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com> <43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com> <43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com> <m31wz9yuoh.fsf@telia.com> <43CB0C81.1030605@cfl.rr.com> <m3oe2cy8ds.fsf@telia.com>
In-Reply-To: <m3oe2cy8ds.fsf@telia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Jan 2006 20:48:04.0408 (UTC) FILETIME=[A4EE9B80:01C61D39]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14216.000
X-TM-AS-Result: No--10.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I got a kernel compiled with your patches, but have not been able 
to test it yet. Last week the red laser crapped out on my sony 710A 
dvd/rw drive, so I got a new 810A and when I go to format the cd-rw with 
cdrwtool, the drive fails the write command with sense code 00.04.04, 
and then fails any commands after that and won't eject the disc until I 
do a hdparm -w. I guess the firmware is defective and craps itself when 
you try to do a packet mode write ( updating didn't help ), so I'm 
returning this drive and ordering the nice sata plextor one instead.

Will let you know when I get the new drive if your patch works out well 
or not.

Peter Osterlund wrote:
> Phillip Susi <psusi@cfl.rr.com> writes:
>
>   
>> I get this:
>>
>> drivers/block/pktcdvd.c:1992: error: label ‘out_unclaim’ used but
>> not defined
>>
>> Also the patch did not cleanly apply. It looks like you didn't get all
>> of your changes into the diff. Unless you have some other patches that
>> I don't? This is against 2.6.15 right?
>>     
>
> I thought it would apply on top of your patch, but didn't actually
> check. Try this patch series instead:
>
>         http://web.telia.com/~u89404340/patches/packet/2.6/2.6.15-git11/
>
>   

