Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282409AbRKXKFq>; Sat, 24 Nov 2001 05:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282410AbRKXKF1>; Sat, 24 Nov 2001 05:05:27 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:43784 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282409AbRKXKFO>; Sat, 24 Nov 2001 05:05:14 -0500
Date: Sat, 24 Nov 2001 09:59:42 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Patrick Cole <z@amused.net>
cc: Pavel Machek <pavel@suse.cz>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: No recording on maestro3 (hp omnibook xe3)
In-Reply-To: <20011124190412.A14605@wapcaplet>
Message-ID: <Pine.LNX.4.33.0111240958090.13861-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2001, Patrick Cole wrote:

> Well my maestro3 works fine recording; cat /dev/dsp gives lots of
> rubbish. I have however noticed that on odd occasion it just stops
> working (no playing or nothing.. totally dead) and a reboot is
> required to get functionality back.  Anyone had this problem before?
>
> This is the maestro3 from the Inspiron 8100.  Here is the relevant data:
>
> maestro3: version 1.22 built at 20:12:16 Nov 13 2001
> PCI: Found IRQ 5 for device 02:03.0
> maestro3: Configuring ESS Maestro3(i) found at IO 0xEC00 IRQ 5
> maestro3:  subvendor id: 0x00e61028
>
> Sep 30 23:32:31 jaded kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 19808 swptr 19808
> Sep 30 23:32:32 jaded kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 19808 swptr 19808

I've just been given a 8100 by my employers, it works well with
2.4.15-pre9. I compile the maestro3 driver as a module so if there's a
problem I can rmmod it and insmod it.  So, far apart from the broken ACPI
stuff, it all seems to work well.

-- 
Broken hearted, but not down.

http://www.tahallah.demon.co.uk

