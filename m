Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVIIL0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVIIL0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVIIL0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:26:31 -0400
Received: from smtp806.mail.ukl.yahoo.com ([217.12.12.196]:8058 "HELO
	smtp806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030248AbVIIL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:26:29 -0400
Message-ID: <43217162.2010401@btinternet.com>
Date: Fri, 09 Sep 2005 12:26:26 +0100
From: Matt Keenan <matt.keenan@btinternet.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: dtor_core@ameritech.net, Eric Piel <Eric.Piel@lifl.fr>,
       Christoph Litters <christophlitters@gmx.de>
Subject: Re: [DRIVER] Where is the PSX Gamepad Driver in 2.6.13-rc3?
References: <42E48CA5.9010709@m1k.net> <43201906.8040902@gmx.de>	 <d120d500050908073942876de5@mail.gmail.com> <43204DD4.3090103@lifl.fr> <d120d500050908075446a4c9e0@mail.gmail.com>
In-Reply-To: <d120d500050908075446a4c9e0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On 9/8/05, Eric Piel <Eric.Piel@lifl.fr> wrote:
>  
>
>>09/08/2005 04:38 PM, Dmitry Torokhov wrote/a écrit:
>>    
>>
>>>On 9/8/05, Christoph Litters <christophlitters@gmx.de> wrote:
>>>
>>>      
>>>
>>>>Hello,
>>>>
>>>>I have an adapter usb to psx i have tried it with 2.6.9 and it works
>>>>perfectly with the kernel driver.
>>>>with 2.6.12 i cant get it to work and with 2.6.13-rc3 i havent seen any
>>>>option to enable it.
>>>>could anybody help me?
>>>>
>>>>        
>>>>
>>>Device Drivers  ---> Input device support  ---> Joysticks  --->
>>>Multisystem, NES, SNES, N64, PSX joysticks and gamepads
>>>
>>>Needs parport support.
>>>
>>>      
>>>
>>Are you sure? Isn't this only for parallel to psx adapters? Christoph
>>says he has a "usb to psx" adapter.
>>
>>    
>>
>
>Oh, yes, sorry. In that case wouldn't HID driver handle it?
>
>  
>
I have such a device myself (send me an email in private if you want to 
confirm it is the same model et al). The HID driver worked just fine. I 
also found that there was almost zero information about this on the net. 
I just use USB, USB HID, USB HID input support, Input support, and the 
Input joystick interface driver. Works just fine, check it with the 
joystick calibrator program of your choice. If your PSX -> USB converter 
doesn't support the joystick HID (which most seem to do) you may need a 
driver of some kind. Or better yet go buy one that does support it, you 
should be able to pick one up for less than $20 USD.

Matt

