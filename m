Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbTJFUia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTJFUia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:38:30 -0400
Received: from main.gmane.org ([80.91.224.249]:35034 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261673AbTJFUiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:38:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet@andreas-s.net>
Subject: Re: Extremely low disk performance on K7S5A Pro
Date: Mon, 6 Oct 2003 20:38:21 +0000 (UTC)
Message-ID: <slrnbo3kmg.4af.usenet@home.andreas-s.net>
References: <slrnbnoi5i.3re.usenet@home.andreas-s.net> <3F813E19.7020303@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:
> Andreas Schwarz said the following on 10/02/2003 05:47 PM:
>
>>Hi,
>>
>>since I replaced my Abit KT7 with an Elitegroup K7S5A Pro (SIS735), I've
>>got extremly low disk performance with every tested kernel version
>>(2.4.20, 2.6.0-test6-mm2):
>>
>># hdparm -tT /dev/hda                                                           
>>/dev/hda:                                                                       
>> Timing buffer-cache reads:   824 MB in  2.00 seconds = 411.65 MB/sec           
>> Timing buffered disk reads:   10 MB in  3.28 seconds =   3.05 MB/sec
>>                                                          ^^^^
>>
>>DMA, 32bit etc. is activated (hdparm -d1 -c3 -u1 /dev/hda):
>>
>>  
>>
>
> 3.05 MB is even less than what I'm used to see with most drives and *PIO 
> 4* !
>
> Is there any ide message in /var/log/messages ?

No, nothing at all.

> I see you use hdparm to setup the drive/controller settings. I advise 
> you to let the kernel autotune the transfer modes by itself.

That doesn't change anything.

> Could you send us :
> - the exact kernel version,

2.6.20-test6-mm2 (but 2.4.20 produces exactly the same result!)

> - your kernel compilation config file,

http://andreas-s.net/kernel/config.gz

> - any kernel parameters provided,

root=/dev/hda7 hdc=ide-scsi hdd=ide-scsi vga=792 noapic

> - the content of /var/log/dmesg,

http://andreas-s.net/kernel/dmesg.gz

> - the output of `lspci -vvxxx`,

http://andreas-s.net/kernel/lspci.gz

> - the ouput of `cat /proc/ide/sis`

http://andreas-s.net/kernel/sis.gz


-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

