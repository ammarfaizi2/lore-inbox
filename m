Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSHDEIm>; Sun, 4 Aug 2002 00:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSHDEIm>; Sun, 4 Aug 2002 00:08:42 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:36747 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318085AbSHDEIl>; Sun, 4 Aug 2002 00:08:41 -0400
Message-ID: <3D4CA95C.6070102@u.washington.edu>
Date: Sat, 03 Aug 2002 21:11:08 -0700
From: Kolbe Kegel <kolbe@u.washington.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: es, es-es, en-us, en
MIME-Version: 1.0
To: Gary White <gary@netpathway.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue
References: <20020803163708.GHUY23840.mta03-svc.ntlworld.com@[10.137.100.63]> <1028397650.1760.8.camel@irongate.swansea.linux.org.uk> <3D4C5209.67385E8C@netpathway.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar issue when I was trying to install a new hard drive. 
this was using 2.4.18, but the boot process would freeze during the 
partition check. the problem on my end was solved by putting the drive 
on a different channel... maybe you should see if that allows you to at 
least boot, not that it helps to actually solve the problem.

Gary White wrote:

>Alan I have the same problem Just complied 2.4.10-ac1 and I it did
>not help. I only have a problem if I compile in the ALI M15x3 chipset
>support so I can use DMA. Without DMA the partition check zooms right
>past the 2 Maxtor 120GB drives I am having a problem with.
>
>Note: I do have an AWARD Bios and have tried the with and without
>Auto-Geometry Resizing support compiled in the kernel.
>
>Oly boots if I don't use DMA and generic controller support.
>
>  
>
>>On Sat, 2002-08-03 at 17:37, alien.ant@ntlworld.com wrote:
>>    
>>
>>>Hi,
>>>
>>>I attempted to upgrade from 2.4.18 to 2.4.19 today but one of machines repeatedly hangs at the "Partition check" on the IDE drives.
>>>
>>>The machine is a Compaq Proliant 800 Pentium III SMP box with a Highpoint 370 IDE controller. I attempted several reboots with the check continually failing. Rebooting back to 2.4.18 removed the problem.
>>>
>>>Searching the archive I note several other people have had this problem with 2.4.19-pre kernels but, as yet, there seems to be no resolution?
>>>
>>>      
>>>
>>Can you try 2.4.19-ac1 once I upload it. That has slightly further
>>updated IDE code and it would useful to know if the same problem occurs
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>


