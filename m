Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319167AbSHTQAM>; Tue, 20 Aug 2002 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319171AbSHTQAL>; Tue, 20 Aug 2002 12:00:11 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:48260 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S319167AbSHTQAL>; Tue, 20 Aug 2002 12:00:11 -0400
Date: Tue, 20 Aug 2002 17:04:15 +0100
Subject: Re: IDE-TNG what to do ?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: John Jones <little.jones.family@ntlworld.com>
In-Reply-To: <1029858112.22983.52.camel@irongate.swansea.linux.org.uk>
Message-Id: <79A12178-B456-11D6-A001-00050291EC35@ntlworld.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alan

I know that SATA can be attached to any IDE device because the 
controller has all the "legacy crap"
I am not saying that you cant do it just that IDE-TNG should "bah 
humbug" it and let the main IDE deal with it

  I am quite happy to hear you say PCI IDE is looking better but really 
it's going to be gone in the next 2 years as PCI just has not got the 
bandwidth for the new drives
(yeah I know PCIX and vax's are still around in terms of legacy machine 
people hang onto but I am sticking my head in the sand and 
singing...SCSI or SAS )

really I am suggesting that you have IDE-TNG just for a few controllers 
and drives
(real world testing is easier)

and the way to restrict the number is to say Serial ATA only

bad or (partly)good ?

regards

John Jones




On Tuesday, August 20, 2002, at 04:41  pm, Alan Cox wrote:

> On Tue, 2002-08-20 at 16:26, John Jones wrote:
>> IDE-TNG should ONLY deal with Serial ATA and ONLY chipset support not
>> PCI based implementations and should be a config option (keep it simple
>> as possible).
>
> SATA bridges attach to any IDE device and any IDE controller. SATA still
> uses PIO. SATA still has to deal with all the other legacy crap.
>
> The view that new IDE somehow gets rid of the old cruft is alas not born
> out by the reality.
>
> In terms of what works. As far as I can tell right now all the PCI stuff
> works in the current -ac cleanup code. There is a weird ide-scsi report
> and one person whose drives have run off somewhere and hidden. Other
> than that its working as well - and in some cases better.
>
> The 2.5 side is about getting the new request queue/bio logic right
> which is something I've not looked into
>
> Alan
>

