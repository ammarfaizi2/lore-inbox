Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbVFYBJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVFYBJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 21:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbVFYBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 21:09:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263203AbVFYBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 21:09:22 -0400
Date: Fri, 24 Jun 2005 18:08:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.12 USB Keypad still not working
Message-Id: <20050624180854.542bb10c.akpm@osdl.org>
In-Reply-To: <42BC7215.3050507@blueyonder.co.uk>
References: <42BC7215.3050507@blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> PhoneSkype USB Phone SK-04.
> It gets detected, is registered in /sys/bus/usb as a Keypad. Everything 
> else USB works including the phone handset. Nothing is detected by 
> showkey when keys are pressed.
> # less /sys/bus/usb/devices/usb3/3-2/3-2:1.3/interface
> Keypad
> 
> /dev/usb/hiddev? and /dev/input/keyboard say they are not valid devices 
> and they are the ones created by the SuSE 9.3 install, not by udev.
> 
>   From dmesg
>   ----------
> usbcore: registered new driver hiddev
> drivers/usb/input/hid-core.c: timeout initializing reports
>                                =============================
> input: USB HID v1.10 Keyboard [BeyondTel USB Phone] on usb-0000:00:02.1-2
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> input: USB HID v1.00 Joystick [CH PRODUCTS CH FLIGHT SIM YOKE USB ] on 
> usb-0000:00:02.1-1.1
> input: USB HID v1.00 Joystick [CH PRODUCTS CH PRO PEDALS USB ] on 
> usb-0000:00:02.1-1.4
> I am puzzled by the fact that the keypad is recognised, but I cannot do 
> anything with it.
> 
> # lsusb
> Bus 003 Device 009: ID 04b8:0103 Seiko Epson Corp. Perfection 610
> Bus 003 Device 008: ID 067b:3507 Prolific Technology, Inc.
> Bus 003 Device 007: ID 068e:00f2 CH Products, Inc. Flight Sim Pedals
> Bus 003 Device 006: ID 05e3:0760 Genesys Logic, Inc. Card Reader
> Bus 003 Device 005: ID 03f0:0604 Hewlett-Packard DeskJet 840c
> Bus 003 Device 004: ID 068e:00ff CH Products, Inc. Flight Sim Yoke
> Bus 003 Device 003: ID 04b4:0303 Cypress Semiconductor Corp. <====
> Bus 003 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> 

Was this hardware known to work on ealier kernels?  If so, which?
