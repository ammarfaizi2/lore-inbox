Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWCHULZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWCHULZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCHULZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:11:25 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:32384 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750749AbWCHULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:11:24 -0500
Message-ID: <440F3A40.2000306@comcast.net>
Date: Wed, 08 Mar 2006 15:10:40 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060307)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Sound userspace drivers (fishing for insight)
References: <440E5746.7070003@comcast.net>	<Pine.LNX.4.61.0603080939360.9337@tm8103.perex-int.cz>	<440F0396.4050905@comcast.net>	<s5h8xrkepxy.wl%tiwai@suse.de>	<440F28C6.6050508@comcast.net> <s5h64moeova.wl%tiwai@suse.de>
In-Reply-To: <s5h64moeova.wl%tiwai@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Takashi Iwai wrote:
> At Wed, 08 Mar 2006 13:56:06 -0500,
> John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Takashi Iwai wrote:
>>> At Wed, 08 Mar 2006 11:17:26 -0500,
>>> John Richard Moser wrote:
>>>>>> into the kernel; with alsa it's written to a /proc interface, which
>>>>> Using /proc? Where? I've not noticed it :-)
>>>> I thought that was what /proc/asound/card0/ was for?  :)
>>> /proc is not referred from alsa-lib, i.e. programs don't access them.
>>> It's just for users who want to read some information.
>>>
>> This makes me wonder then how stuff is set up.  There's no device, is
>> there a sound card syscall now?
> 
> You must have /dev/snd/* files, and the access is via normal
> syscalls...  Check strace of your program.
> 

Ahh nice, I was always looking for /dev/dsp :>

> 
> Takashi
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRA86Pws1xW0HCTEFAQIr9w//at9VpczxSKrCUzQGMYe33SW2vrksVVIg
dTE12O1cc3gw0PK5UaD/QiN9+uoHKXY1YSkBBeCQQ2We50txjuy30jZ0j8PhkE22
PmuMb2knq9isspAT6Mr0ErRLS1+2FEvVN52yWwustl8cMiGrq812bYq63YHhGTPe
1b587S9+/wrEmswfA5/dvfJ+iEr3rHM0X7JPzJ721ayU1oeisAHw2GQCiXxQfwXZ
aqOCnDRr7VgiPgnMC0nu8JVbNEdvJru4Dwgkc2siXoLnYmFYOiLv8JzujDJH3NfP
aVxJ/NaoryvDSWXTcLOhm2nXKO7hD6id6wmd4ncSLedieK2Pw9WyAnVl40JguYgG
OrTzmwJsYcc++isyLcYoDyJi861Urhly4Umnx8GQRxhpzJJ31eX+6pnNaic1f9Rv
CNKOKrhLYG1AjqvDn0A1gyarMbXuXWu9D8Cjtv89nISr3AbGhq2Hz4oG78zRTiOX
S56wnL8432RwhahQOkMSyJVdrxszN56FYiraWwfclrpAdE8TujV1YPYPG8qo2EGH
9vk6O0ZVccZUiyt3WLnyl+r/PLdsEaiFzrG7l0HANWq6KcCES8FClhfrWueCFQlM
4e7yAofQSKzJ1GrofaghVLloEJjoAoCWrJcVHMv6gAkPa8m8pwK9tUul3FRdDMD/
1EHU/9tOMmY=
=8+gV
-----END PGP SIGNATURE-----
