Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292733AbSBUTXL>; Thu, 21 Feb 2002 14:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292732AbSBUTXC>; Thu, 21 Feb 2002 14:23:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292730AbSBUTWt>; Thu, 21 Feb 2002 14:22:49 -0500
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
To: tepperly@llnl.gov (Tom Epperly)
Date: Thu, 21 Feb 2002 19:36:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211010270.19681-100000@tux06.llnl.gov> from "Tom Epperly" at Feb 21, 2002 10:26:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dz1I-0007ys-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > tends to be a pointer to thinks like cache faults.
> Is there any way to test this?

Well in theory the cpu should report it with a machine check (which we
would report). Sometimes it doesnt

> By running without the X11 server, I hoped to remove the nVidia board as a 
> source of trouble.

If you booted and never ran X or hand loaded the nvidia module you did that

> 00:00.0 Host bridge: Intel Corporation 82850 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)

when you see the nicknames it makes you wonder if intel know that wombat is
"waste of money brains and time" in business speak 8)

Nothing else in the hardware really stands out. You can avoid the sb live!
for testing I guess but I wouldnt have expected it to be a problem.

Possibly one hardware thing to try (depending on who and how the box is
maintained) is swapping the cpus over and seeing if it then works single
cpu..
