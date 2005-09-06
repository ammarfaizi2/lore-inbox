Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVIFJk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVIFJk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVIFJk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:40:57 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:6379 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964780AbVIFJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:40:56 -0400
Message-ID: <431D6424.4050307@anagramm.de>
Date: Tue, 06 Sep 2005 11:40:52 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vinay hegde <thisismevinay@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: Regarding the booting the linux kernel on a > PPC board.
References: <20050905120625.70268.qmail@web8403.mail.in.yahoo.com>
In-Reply-To: <20050905120625.70268.qmail@web8403.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinay!

You might want to turn on kernel debugging and also the
early printk support.

You also might want to come over to the linuxppc-embedded
and linuxppc-dev mailinglists at ozlabs.org where those question
are pretty well known. Tell us more about your board/system,
check the archives!

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

vinay hegde wrote:
>>Hi All,
>> 
>>I am working on bringing up a PowerPC based board
>>with Linux 2.6 kernel (Board supoort package).
>>However, I am facing some problem with respect to
>>debugging.
>> 
>>When I boot the board with the Linux kernel (BSP),
>>the board hangs after printing the following
>>information.
>> 
>>
>>Network Loading from: /dev/enet0 
>>
>>Client IP Address      = 192.168.4.38 
>>Server IP Address      = 192.168.4.101 
>>Gateway IP Address     = 192.168.4.253 
>>Subnet IP Address Mask = 255.255.255.0 
>>Boot File Name         = developer.kdi 
>>Load Address           = 04000000 
>>Buffer Size = 2000000 
>>
>>Network Boot File Load Start - Press <ESC> to
>>Bypass, <SPC> to Continue 
>>
>>
>>Bytes Received =&6141952, Bytes Loaded =&6141952 
>>Bytes/Second   =&511829, Elapsed Time =12 Second(s) 
>>
>>Boot Device       =/dev/enet0 
>>Boot File         =developer.kdi 
>>Load Address      =04000000 
>>Load Size         =005DB800 
>>Execution Address =04000020 
>>Execution Offset  =00000020 
>>
>>Passing control to the loaded file/image. 
>>loaded at:     00800000 00DD8800 
>>zimage at:     008058E0 009933BB 
>>initrd at:     00998000 00DD8800 
>>avail ram:     00400000 00800000 
>>
>>Linux/PPC load: console=ttyS0,9600 console=tty0
>>root=/dev/sda2 
>>console=ttyS0,9600 root=/dev/ram rw 
>>Uncompressing Linux...done. 
>>Now booting the kernel 
>>
>>
>>
>>>>>>>>>>>>>>>>>>>>>>>. 
>>
>>I am going through the source code to figure out the
>>problem, but unable to find out what is going wrong
>>here.
>>
>>Does anybody have any idea about the problem? Also,
>>is it possible to print some debug messages at this
>>point of booting? {Note that, in the early stage of
>>booting process the serial is initialized and all
>>the above mentioned messages (like Uncomressing
>>Linux, Now booting the kernel etc) are printed. And
>>immediately after printing the "now booting the
>>kernel message,the serial is closed. This code is in
>>uncompress_kernel() function in
>>arch/ppc/boot/simple/misc.c file).
>>
>>Can somebody help me with the above problem?
>>
>>Thank you,
>>
>>vinay hegde.
>>
> 
> 
> 
> 
> 	
> 
> 	
> 		
> __________________________________________________________ 
> Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
