Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSGaVnT>; Wed, 31 Jul 2002 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSGaVnT>; Wed, 31 Jul 2002 17:43:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:8669 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318510AbSGaVnS>; Wed, 31 Jul 2002 17:43:18 -0400
X-KENId: 00001BF0KEN47E0FDF8
Date: Wed, 31 Jul 2002 23:41:26 +0200
From: Thomas <thomas@mierau.org>
Subject: Re: Tyan K7X with AMD MP 2.4.19-rc3-ac4
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Thomas Mierau <tmi@wikon.de>, linux-kernel@vger.kernel.org
Message-Id: <3D485986.3010101@mierau.org>
References: <5.1.0.14.0.20020730142822.009ef030@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
User-Agent: Mozilla/5.0 (Windows; U; Win98; de-DE; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank's Rudmer

Actually it is disabbled intentionally. The eth0 will install itself on 
the IRQ11 and I didn't find a way to get it somewhere else. IRQ11 is 
used by the SCSI Raid Controller already whic is fixed in the 66Mhz 
64Bit slot(and later on by another onbord AIC7xxx device which I am also 
unable to reroute up to now)
And even the eth1 is not working properly

Rudmer van Dijk wrote:

> At 14:21 30-7-02, Thomas Mierau wrote:
> 
>> Hi
>>
>> I am trying to get the above board to work. Somehow it doesn't.
>> I tried kernel  2.4.18, 2.4.19-rc3, 2.4.19-rc3-ac3 and of course the 
>> latest
>> 2.4.19-rc3-ac4
>>
>> The machine itself is "working" stable under 2.4.18 with a limited
>> functionality (no network, no additional scsi ports, no printer, no 
>> usb ...)
>>
>> The problem is always the same. The eth1 is not working properly and 
>> the IRQ's
>> are not setup correctly. The I/O-APIC reports ok.
> 
> 
> i don't know about the IRQ's but the second nic can be enabled by 
> entering 'ether=0,0,eth1' at the kernel commandline. see also the file 
> for your networkcard in Documentation/networking or see section 2.3 of 
> the Ethernet HOWTO.
> 
>         Rudmer
> 
> 
> 


