Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268913AbTGJAJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268903AbTGJAIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:08:18 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:47848 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S268889AbTGJAFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:05:35 -0400
Message-ID: <3F0CB01F.5070308@rackable.com>
Date: Wed, 09 Jul 2003 17:15:27 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: Promise SATA 150 TX2 plus
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor> <3F0C5D55.4030304@rackable.com> <039701c34675$81a8b0e0$401a71c3@izidor>
In-Reply-To: <039701c34675$81a8b0e0$401a71c3@izidor>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 00:20:12.0191 (UTC) FILETIME=[072D6AF0:01C34679]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Roubal wrote:

>Hi,
>  
>
>>Milan Roubal wrote:
>>
>>    
>>
>>>So other question - is there SATA controler that
>>>is working in linux multiple controlers (4 cards)
>>>and is for better bus than standart PCI? Like PCI-X or
>>>PCI 66 MHz like promise is?
>>>
>>>
>>>      
>>>
>>  Most current SATA cards aren't faster than 64/66.  Heck many are
>>32/66, or 64/33.  The problem is most everyone other than 3ware's linux
>>drivers suck.  I can't find a non raid SATA controller than works for me
>>under linux.
>>
>>    
>>
>
>Heh, bad news for me.
>
>  
>
>>  3ware cards tend to max out a 64/33 solt around 6 drives for
>>sequential IO.  (This will change in their next gen cards)  You get much
>>better performance with two 8 port cards running 6 drives each than a
>>single 12 port card.  Personally I recommend either 3ware raid10, or
>>linux software raid 5 if you're a performance junky.
>>
>>  Adaptec does have a new 4 port card sata raid card.  It seems to work
>>well, and the driver on their cdrom includes around 30 precompiled
>>binaries for various RH, MDK, and Suse kernels.  Source for the updated
>>aacraid driver is included.   An interesting side note their cdrom seem
>>to run linux.  (Yes they seem to provide source/patches for the various
>>gpl programs it uses.)
>>
>>-- 
>>Once you have their hardware. Never give it back.
>>(The First Rule of Hardware Acquisition)
>>Sam Flory  <sflory@rackable.com>
>>
>>    
>>
>
>All this cards are RAID controllers, I want only SATA controlers and I am
>using software raid 5.
>I was using Promise TX2 controllers for PATA drives and it was working
>great, so I tried
>the SATA card from Promise too and it looks only troubles and troubles...
>    Milan Roubal
>
>  
>

  Your best bet may be some silcon image chipset, or the high point card 
that seem to have the same interface as their pata card.  Personally at 
this stage there really isn't any reason to switch to sata.  (Other than 
saner cabling.)  I've yet to see a sata drive, other than the WD raptor, 
that faster than pata drive.  The WD raptors are nearly scsi drive fast, 
but are small cap and pricey.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


