Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263213AbVFXUuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbVFXUuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbVFXUuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:50:52 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:61393 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263213AbVFXUu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:50:29 -0400
Message-ID: <42BC7215.3050507@blueyonder.co.uk>
Date: Fri, 24 Jun 2005 21:50:29 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 USB Keypad still not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2005 20:51:09.0092 (UTC) FILETIME=[72AD6640:01C578FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PhoneSkype USB Phone SK-04.
It gets detected, is registered in /sys/bus/usb as a Keypad. Everything 
else USB works including the phone handset. Nothing is detected by 
showkey when keys are pressed.
# less /sys/bus/usb/devices/usb3/3-2/3-2:1.3/interface
Keypad

/dev/usb/hiddev? and /dev/input/keyboard say they are not valid devices 
and they are the ones created by the SuSE 9.3 install, not by udev.

  From dmesg
  ----------
usbcore: registered new driver hiddev
drivers/usb/input/hid-core.c: timeout initializing reports
                               =============================
input: USB HID v1.10 Keyboard [BeyondTel USB Phone] on usb-0000:00:02.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
input: USB HID v1.00 Joystick [CH PRODUCTS CH FLIGHT SIM YOKE USB ] on 
usb-0000:00:02.1-1.1
input: USB HID v1.00 Joystick [CH PRODUCTS CH PRO PEDALS USB ] on 
usb-0000:00:02.1-1.4
I am puzzled by the fact that the keypad is recognised, but I cannot do 
anything with it.

# lsusb
Bus 003 Device 009: ID 04b8:0103 Seiko Epson Corp. Perfection 610
Bus 003 Device 008: ID 067b:3507 Prolific Technology, Inc.
Bus 003 Device 007: ID 068e:00f2 CH Products, Inc. Flight Sim Pedals
Bus 003 Device 006: ID 05e3:0760 Genesys Logic, Inc. Card Reader
Bus 003 Device 005: ID 03f0:0604 Hewlett-Packard DeskJet 840c
Bus 003 Device 004: ID 068e:00ff CH Products, Inc. Flight Sim Yoke
Bus 003 Device 003: ID 04b4:0303 Cypress Semiconductor Corp. <====
Bus 003 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
