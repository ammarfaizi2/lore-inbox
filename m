Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTBXQnX>; Mon, 24 Feb 2003 11:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTBXQnX>; Mon, 24 Feb 2003 11:43:23 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:8953 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267264AbTBXQnW>; Mon, 24 Feb 2003 11:43:22 -0500
Date: Mon, 24 Feb 2003 11:53:34 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb keyboard stuck?
Message-ID: <20030224115334.A17410@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I've just had an odd occurance with a USB keyboard setup where the 
shift / alt / control keys became stuck.  The only way to get sane 
control of the system back was to unplug the usb keyboard and plug 
it back in.  Note that upon plugging it back in, the system logged 
a few unknown scancode messages, which seems a bit odd.  Any ideas 
if this is the fault of the keyboard or the driver?  Info on any 
experiences might be helpful, especially if someone else is using a 
Logitech iTouch keyboard.  Cheers,

		-bben
--
Junk email?  <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>

application bug: xterm(9022) has SIGCHLD set to SIG_IGN but calls wait().
(see the NOTES section of 'man 2 wait'). Workaround activated.
usb.c: USB disconnect on device 02:06.1-2.1.2 address 4
usb.c: USB disconnect on device 02:06.1-2.1.2.1 address 6
usb.c: USB disconnect on device 02:06.1-2.1.2.3 address 7
hub.c: new USB device 02:06.1-2.1.2, assigned address 8
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 02:06.1-2.1.2.1, assigned address 9
input0: USB HID v1.10 Keyboard [LOGITECH USB Keyboard] on usb3:9.0
input1: USB HID v1.10 Pointer [LOGITECH USB Keyboard] on usb3:9.1
hub.c: new USB device 02:06.1-2.1.2.3, assigned address 10
input2: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb3:10.0
keyboard: unknown scancode e0 3a
keyboard: unknown scancode e0 1e
keyboard: unknown scancode e0 1e
keyboard: unknown scancode e0 0e
keyboard: unknown scancode e0 2e
keyboard: unknown scancode e0 2e
keyboard: unknown scancode e0 0e
keyboard: unknown scancode e0 0e
keyboard: unknown scancode e0 13
keyboard: unknown scancode e0 33
keyboard: unknown scancode e0 33
keyboard: unknown scancode e0 23

