Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130678AbRBHIBw>; Thu, 8 Feb 2001 03:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbRBHIBm>; Thu, 8 Feb 2001 03:01:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130678AbRBHIB1>; Thu, 8 Feb 2001 03:01:27 -0500
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
To: sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg)
Date: Thu, 8 Feb 2001 08:02:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3A8205D4.7C7E358E@Hell.WH8.TU-Dresden.De> from "Udo A. Steinberg" at Feb 08, 2001 03:35:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Qm1u-0002nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure whether this is related to the ominous ps/2 mouse bug
> you have been chasing, but this problem is 100% reproducible and
> very annoying.

It isnt but it might be related to which 2.2.19pre you are running (if any)

> After upgrading my Asus A7V Bios from 1003 to 1005D, gpm no longer
> receives any mouse events and the mouse doesn't work in text
> consoles. Once I kill gpm and restart gpm -t ps2 the keyboard
> locks up.

Does downgrading the bios fix it. If so then I suspect you need to talk to
the BIOS vendor.  You might find that turning off USB legacy keyboard/mouse
emulation helps too


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
