Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSEBVV5>; Thu, 2 May 2002 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSEBVV4>; Thu, 2 May 2002 17:21:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49168 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315430AbSEBVVz>; Thu, 2 May 2002 17:21:55 -0400
Message-ID: <3CD19F19.2030104@evision-ventures.com>
Date: Thu, 02 May 2002 22:18:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
In-Reply-To: <20020502215833.V31556@unthought.net> <E173N9y-0004k1-00@the-village.bc.nu> <20020502231359.W31556@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jakob Østergaard napisa?:
> On Thu, May 02, 2002 at 09:26:38PM +0100, Alan Cox wrote:
> 
>>>>=20
>>>>8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
>>>>a classical RAID controller card for this kind of
>>>>setup.
>>>
>>>Because RAID controllers do not use the PCI bus ???    ;)
>>
>>The raid card transfers the data once, software raid once per device for
>>Raid 1/5 - thats a killer.
> 
> 
> For RAID-1 it's a killer (for writes), I agree.
> 
> But I really doubt it would be so horrible for RAID-5 - after all, it's only
> one extra block (the parity block) for each N-1 blocks written (for an N disk
> RAID-5).  The penalty should be less, the more disks you have in the array.
> 
> But seriously, has anyone out there ever seen a hardware RAID controller with
> a *sustained* RAID-5 thoughput of more than 60 MB/sec ?   Not that I think it
> is impossible, but I've never heard about it.  Enlighten me, please, and not
> with marketing numbers...


Go to Sun hardware and you will see it quite frequently even on a simple
E450 equipped with an external RAID box. I saw them frequently enough in
sar accounts when the system was configured to trash on a swap
partition, which resided on such a RAID.

64 bit buses win here by a huge margin.

