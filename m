Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267788AbTAHRl2>; Wed, 8 Jan 2003 12:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267799AbTAHRl2>; Wed, 8 Jan 2003 12:41:28 -0500
Received: from zeke.inet.com ([199.171.211.198]:24476 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267788AbTAHRl1>;
	Wed, 8 Jan 2003 12:41:27 -0500
Message-ID: <3E1C64CE.8050709@inet.com>
Date: Wed, 08 Jan 2003 11:50:06 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Murray J. Root" <murrayr@brain.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC
References: <20030108165130.GA1181@Master.Wizards> <20030108173356.GA1189@Master.Wizards>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murray J. Root wrote:
> Ooops - kernel 2.5.5[234]
> 
> On Wed, Jan 08, 2003 at 11:51:30AM -0500, Murray J. Root wrote:
> 
>>ASUS P4S533 (SiS645DX chipset)
>>P4 2GHz
>>1G PC2700 RAM
>>SanDisk SDDR-77 ImageMate Dual Card Reader (using only CF cards)
>>
>>----------------------------
>>devfs compiled in to kernel, devfs=nomount in lilo.conf
>>  
>>Insert CF card. mount it. cd to it, do reads and/or writes
>>umount card. remove card.
>>insert a different card (does not happen if the same card is used)
>>mount it. system reboots. logs are corrupted
>>
>>Doesn't happen every time for read - sometimes I can read 2 or 3 cards first
>>Happens every time for write - if I write to a card then changing cards
>>causes a reboot
>>
[snip]

Somewhat similar vein, but a different set of symptoms, I've seen a 
RedHat box not see that the CF card changed...
(USB SanDisk CF & SD reader, also using only CF cards.)

insert 128MB CF card.
everything is ok.
remove 128MB CF card, still see 128MB partition
insert 256MB CF card.
see 128MB partition.
(based on /proc/partitions)

I've not followed this up to figure out why yet.
You might check that situation to see if yours is related at all.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

