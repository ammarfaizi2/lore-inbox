Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbXAIWgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXAIWgR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbXAIWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:36:16 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:53615 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbXAIWgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:36:15 -0500
Message-ID: <45A412FE.9000302@wolfmountaingroup.com>
Date: Tue, 09 Jan 2007 15:11:10 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Auke Kok <sofar@foo-projects.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A4003A.3080403@wolfmountaingroup.com> <45A40B83.2060009@foo-projects.org>
In-Reply-To: <45A40B83.2060009@foo-projects.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:

> Jeff V. Merkey wrote:
>
>> Jeff V. Merkey wrote:
>>
>> root=/dev/hda2 is what was passed to the kernel from grub.
>>
>> Jeff
>>
>>>
>>> I just finished pulling out a melted IDE flash drive out of a 
>>> Shuttle motherboard with the intel 945 chipset which claims to support
>>> SATA and IDE drives concurrently under Linux 2.6.18.
>>>
>>> The chip worked for about 30 seconds before liquifying in the 
>>> chassis.  I note that the 945 chipset in the shuttle PC had some 
>>> serious
>>> issues recognizing 2 x SATA devices and a IDE device concurrently.   
>>> Are there known problems with the Linux drivers
>>> with these newer chipsets.
>>>
>>> One other disturbing issue was the IDE flash drive was configured 
>>> (and recognized) as /dev/hda during bootup, but when
>>> it got to the root mountint, even with root=/dev/hda set, it still 
>>> kept thinking the drive was at scsi (ATA) device (08,13)
>>> and kept crashing with VFS cannot find root FS errors.
>>
>
> it sounds like someone switched the BIOS IDE setting from 
> ide-compatible/legacy to AHCI or similar, a not uncommon option in the 
> sata controllers on those boards.
>
> None of that would explain the melting of anything of course.


Would be if pin 20 were powered for some reason (which it should NOT 
be).     

Jeff

>
> Cheers,
>
> Auke
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

