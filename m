Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRKDAVo>; Sat, 3 Nov 2001 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRKDAVg>; Sat, 3 Nov 2001 19:21:36 -0500
Received: from hermes.toad.net ([162.33.130.251]:9964 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276751AbRKDAVU>;
	Sat, 3 Nov 2001 19:21:20 -0500
Subject: Re: [PATCH] IBM T23; quirks force enable interrupts in APM set
	power state, causes crash on suspend
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh <linux-kernel@alex.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 03 Nov 2001 19:20:37 -0500
Message-Id: <1004833243.5995.852.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Summary: dmi_scan.c forces interrupt enable on during PCI BIOS
> call for all IBM machines, which breaks T23, which needs it
> off it seems.
[...]
> BIOS Vendor: IBM
> BIOS Version: 1AET38WW (1.01b)
> BIOS Release: 07/27/2001

I would suggest that you try upgrading your firmware before
concluding that your patch is necessary.  The latest firmware
listed on IBM's website is version 1.03 = 1AET43WW,
released 19 October 2001.  There have been a LOT of changes since
version 1.01 of the firmware.  Here is IBM's changelog:

> I. Summary of changes
> version 1.01 - 1AET38WW
>
> (New) Support for ThinkPad T23.
>
> version 1.02 - 1AET40WW
>
> (New) Support F11 key handling on logo screen for new
>       recovery program.
> NOTE: xKx and xLx models are not supported.
> (Fix) IBM Token-Ring PC card does not work after Hibernation
>       wakeup under Microsoft Windows 98.
> (Fix) FDD read/write access fail on Microsoft Windows XP.
> (Fix) POST 175 error appear.
> (Fix) USB device which is connected to USB port in docking
>       station does not work on Microsoft Windows 95.
> (Fix) System can not boot from USB Portable Device Bay.
> (Fix) Japanese message of eFlash is corrupted.
> (Fix) Two different docking configuration is made.
> (Fix) Ctrl+Alt+Del cause system hang on DOS/V.
> (Fix) Blue screen appear after standby/resume on Microsoft
>       Windows 2000 or Windows XP.
> (Fix) Noise appear when TV out is used.
>
> version 1.03 - 1AET43WW
>
> (Fix) Resume hang occur on Windows 2000 when USB CCD
>       camera is attached.
> (Fix) RIPL from PCMCIA TokeRing adapter card in docking station
>       does not work.
> (Fix) UltraDMA mode 5 (ATA/100) does not enabled on Windows 2000.





