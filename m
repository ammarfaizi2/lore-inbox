Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTK3Rj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTK3Rj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:39:29 -0500
Received: from lgsx14.lg.ehu.es ([158.227.2.29]:6629 "EHLO lgsx14.lg.ehu.es")
	by vger.kernel.org with ESMTP id S264976AbTK3RjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:39:25 -0500
Message-ID: <3FCA39C2.9070907@wanadoo.es>
Date: Sun, 30 Nov 2003 19:41:06 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031118 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: Re: Silicon Image 3112A SATA trouble
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so definitely, 32 MB/s is almost half the speed that you get. I'm in 
2.6-test11. I don't know more options to try. The next will be booting 
with "noapic nolapic". Some people reported better results with this.

by the way, I have booted with "doataraid noraid" (no drives connected, 
only SATA support in bios), and nothing is shown in the boot messages 
(nor dmesg) about libata being loaded. I don't know if I must connect a 
hard drive and then the driver shows up, but I don't think that.


Thanks!

LuisMi Garcia


Craig Bradney wrote:

> On the topic of speeds.. hdparm -t gives me 56Mb/s on my Maxtor 80Mb 8mb
> cache PATA drive. I got that with 2.4.23 pre 8 which was ATA100 and get
> just a little more on ATA133 with 2.6. Not sure what people are
> expecting on SATA.
>
> Craig
>
> On Sun, 2003-11-30 at 18:52, Luis Miguel García wrote:
>  
>
>> hello:
>>
>> I have a Seagate Barracuda IV (80 Gb) connected to parallel ata on a 
>> nforce-2 motherboard.
>>
>> If any of you want for me to test any patch to fix the "seagate 
>> issue", please, count on me. I have a SATA sis3112 and a 
>> parallel-to-serial converter. If I'm of any help to you, drop me an 
>> email.
>>
>> By the way, I'm only getting 32 MB/s   (hdparm -tT /dev/hda) on my 
>> actual parallel ata. Is this enough for an ATA-100 device?
>>
>> Thanks a lot.
>>
>> LuisMi García
>> Spain
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>   
>
>
>
>  
>


