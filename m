Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSL3Uq2>; Mon, 30 Dec 2002 15:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSL3Uq1>; Mon, 30 Dec 2002 15:46:27 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:57092
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S265998AbSL3Uq1>; Mon, 30 Dec 2002 15:46:27 -0500
Date: Mon, 30 Dec 2002 15:58:31 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: [OLD BUG][2.4][USB]: USB/PS2 Emulation - Resolved in 2.5
Message-ID: <Pine.LNX.4.44.0212301553360.25429-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Going though some mail cleaning...

Hi Greg, Just letting you know this is resolved in 2.5. Also, the USB
controller onboard is 1.1.

>>From:     Greg KH <greg () kroah ! com>
>>Date:     2002-01-03 1:01:07

> I have a Pentium 200Mhz AMD Bios (home machine):
>
> USB 1.0 - 2 ports

Ouch.  Watch out when using a hub.  They generally want 1.1 support.

> The bios has 2 options:
>
> Enable USB controller and enable USB legacy stuff.
>
> If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
> in. I get:
>
> 1) Slow loading of kernel into memory on bootup
> 2) AT keyboard timeout (?) errors and no activity with the keyboard
> (shift lock/numlock/scroll lock). I  have to reboot to correct the
> problem by disabling USB in the bios.

Do you only have a USB keyboard, and no PS2 keyboard attached?
Is the "Enable USB legacy" stuff enabled in your bios?

Does things work better if you load the usb host controller for your
machine?

thanks,

greg k-h

