Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbTABTji>; Thu, 2 Jan 2003 14:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTABTji>; Thu, 2 Jan 2003 14:39:38 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:64273
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S266353AbTABTjh>; Thu, 2 Jan 2003 14:39:37 -0500
Message-ID: <3E14976C.8090403@rackable.com>
Date: Thu, 02 Jan 2003 11:47:56 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <20030102185921.GA28107@linux.kappa.ro> <3E14911C.7010009@rackable.com> <20030102192316.GA28781@linux.kappa.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 19:48:01.0866 (UTC) FILETIME=[DBE292A0:01C2B297]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Teodor Iacob wrote:

>>>00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
>>>IDE (rev 06)
>>>
>>>hdd: Maxtor 6Y060L0, ATA DISK drive
>>>
>>>the harddisk is DiamondPlus9 60GB 7200 rpm UDMA133 .. and the mainbboard 
>>>is Soltek 75-FRV
>>>with KT400 chipset
>>>
>>>
>>>      
>>>
>> What's hdc?  Hdd is the secondary slave.  If it's the only device on 
>>the chain you should make sure you jumper the drive as a master.
>>    
>>
>
>HDC it's a CD-RW .. it was not used at the time of the error ( i was doing
>mke2fs on hdd1 when I got those errors in dmesg ).
>
>  
>

  Try setting the cd-rw as a slave, and the hard drive as a master.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



