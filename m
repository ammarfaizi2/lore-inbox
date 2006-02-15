Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWBOWCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWBOWCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWBOWCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:02:13 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:44635 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751297AbWBOWCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:02:12 -0500
Message-ID: <43F3A4EA.3040000@tls.msk.ru>
Date: Thu, 16 Feb 2006 01:02:18 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: readahead logic and I/O errors
References: <43F39089.2050302@tls.msk.ru> <Pine.LNX.4.61.0602151549190.10849@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602151549190.10849@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 15 Feb 2006, Michael Tokarev wrote:
> 
> 
>>The thing is: I just fired a cdrom drive in my PC.
>>It was a good device, and now it's dead.
>>And the reason is the readahead logic, plus an unreadable
>>(damaged, scratched) CD-rom.
[]
> Aside from the obvious read-ahead bug you discovered, have you
> tried your CD drive after the reboot? It is not possible to
> kill those things with software, even if attempting to write
> with too much infrared LED drive. There is nothing except for
> the removable disc to get hurt. Even the "head" isn't in contact.
> It's just some infrared light, focused with a voice-coil, that
> moves on a fixed platform.

I opened the drive after BIOS didn't detect it on reboot (after
power-off).  There's one fired (burned? perished? how's that in
english?) chip on the plate, wich smells like fired silicone.
  It looks like a ~5mm pit in the center of square chip, full of
ache, and there's a crack across it.  The drive is dead.

I think it's a chip which controls one of the motors of the drive,
most probably the one which moves the head, because the head
motor connector is right near the chip.

When I turned off power, the drive was *hot*, and it started
"trembling" (or chattering) when I turned power off.

It was a dvd-cd combo (read dvd, read-write cd) Teac drive, I
don't remember the model (there's no label on the drive, and
I can't send inquiry/identify command to it anymore, obviously).

Yest it looks like a problem in the drive *too*, as it should
not behave like that in the first place.  But the thing is, I
did know something's bad going on, I saw it, but I wasn't able
to stop it from linux, only poweroff stopped things from going.

/mjt
