Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUGOPoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUGOPoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUGOPoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:44:02 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:9733 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266218AbUGOPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:43:59 -0400
Message-ID: <40F6AC0F.1010309@techsource.com>
Date: Thu, 15 Jul 2004 12:08:47 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Timothy Miller <theosib@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: HELP:  Cannot get ALSA working on via82xx
References: <BAY1-F133LSW50Pfs56000059d7@hotmail.com>	<40EC406E.5010809@techsource.com> <s5hk6x9cseh.wl@alsa2.suse.de>
In-Reply-To: <s5hk6x9cseh.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for responding!


Takashi Iwai wrote:
> At Wed, 07 Jul 2004 14:26:54 -0400,
> Timothy Miller wrote:
> 
>>I must once again reiterate my begging for help on this topic.  I've 
>>gotten lots of help on the gentoo forum, but none of it's fixed my 
>>problems, and I've only gotten one response on LKML.
>>
>>*BEG* *BEG* *BEG*
>>
>>Please, won't someone take pity on me?  :)  Thanks!
> 
> 
> via82xx doesn't support MPU401 by itslef although via686 does.

I'm not sure if I have via686 or not.  Various tools like lspci don't 
seem to reveal much.

That's one of the problems I keep running into with Linux.  There aren't 
good tools for finding out what you have, and even when you do find out 
what you have, it's hard to figure out which modules you need, because 
the module names don't correspond well with the chipset name. 
Furthermore, there doesn't seem to be a good way to relate module names 
with menuconfig entries.  When someone says to use xyz module, I can't 
figure out which menuconfig option to select, so I have to compile ALL 
of them as modules, and when someone tells me to use a given menu 
option, I can't figure out which module corresponds to it.

> You can try snd-mpu401 module instead.  

Well, I have a module snd-mpu401, but when I modprobe it, I get an error 
about a non-existant device.

 > When ACPI is enabled, the
> configuration will be done automatically.
> The midi device can be available as the second card.

Ah, well, I had nightmares trying to use ACPI.  I use just APM for 
things like power-off (power-off works with APM, but not with ACPI). 
Maybe some of the experts can help me to figure out how to get it all to 
work.

I'm about ready to give up on ALSA and go back to OSS.  Maybe someone 
can help me to figure out how to get MIDI sequencing to work with OSS 
instead.  OSS would at least do audio right without noise and popping 
sounds, etc.

I apologize for the impatient nature of this post... I've been 
struggling for weeks to get audio working right with ALSA, but every 
piece of advise I get seems only to make things worse.

 From what I read on various web sites, ALSA for via82xx is so buggy 
that it's really not worth using yet.

