Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268536AbTBWTzt>; Sun, 23 Feb 2003 14:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268538AbTBWTzt>; Sun, 23 Feb 2003 14:55:49 -0500
Received: from imo-r07.mx.aol.com ([152.163.225.103]:54004 "EHLO
	imo-r07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S268536AbTBWTzs>; Sun, 23 Feb 2003 14:55:48 -0500
Message-ID: <3E59299B.8090200@netscape.net>
Date: Sun, 23 Feb 2003 12:05:47 -0800
From: Sheng Long Gradilla <skamoelf@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?VG9wbGljYSBUYW5hc2tvdmnEhw==?= <toptan@EUnet.yu>
CC: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu> <200302231450.47506.toptan@EUnet.yu> <3E58F07B.3030801@netscape.net> <200302231921.27024.toptan@EUnet.yu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "other kernels" I am talking about are 2.4.19 and 2.4.20 with the 
old agpgart. As I said, the new agpgart module now loads but the results 
are the same. I yet have to try some other tricks like setting the AGP 
rate manually.

I am also using the latest nvidia modules, which are 1.0-4191


- Sheng Long Gradilla

Toplica Tanasković wrote:
> Dana nedelja 23. februar 2003. 17:02 napisali ste:
> 
>>I tested on an Asus A7V8X motherboard (KT400) with a GeForce4 Ti 4200
>>AGP8X. The module loads correctly, at last! It sets the apperture size
>>correctly and all, but when I start XFree, I get do not get any
>>graphical screen, but text mode garbage. Characters of all colors, with
>>no sense at all. I had exactly the same problem in other kernels.
>>
> 
>     What kernels? Are you using old agpgart or new one with other kernels?
> 
> 
>>I played a bit with the NvAGP option on XF86Config file. According to
>>the documentation, 0 is PCI mode, 1 is NvAGP or fallback to PCI if
>>failed, 2 is AGPGART mode or fallback to PCI if failed, 3 is autodetect.
>>If I set it to 2, 3 or comment it, I got the same problem with the
>>garbage and had to reset the PC. Setting it to 0 would make it run in
>>PCI mode, and it always works. I tried setting it to 1, thinking that
>>maybe the documentation is wrong. X started successfully, but the card
>>was in PCI mode. I read the logs to confirm it, and indeed, the NvAGP
>>module fails to identify the AGP chipset and falls back to PCI.
>>
>>I tried setting NvAGP to 2 again, to read the logs and see if there is
>>something I could find out, but unfortunately the log had nothing but
>>garbage. I tried several times with no success. The log is always garbage.
>>
> 
>     Try fetching latest nVidia drivers.
> 
>     I'll try to isolate problem, and send patch if neccessery.
> 
> 
>>- Sheng Long Gradilla
> 
> 

