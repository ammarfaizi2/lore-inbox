Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJEQJJ>; Sat, 5 Oct 2002 12:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSJEQJJ>; Sat, 5 Oct 2002 12:09:09 -0400
Received: from tristate.vision.ee ([194.204.30.144]:44227 "HELO vision.ee")
	by vger.kernel.org with SMTP id <S262397AbSJEQJC> convert rfc822-to-8bit;
	Sat, 5 Oct 2002 12:09:02 -0400
From: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Organization: Vision Group LLC
To: linux-kernel@vger.kernel.org
Subject: USB problems with 2.4
Date: Sat, 5 Oct 2002 19:14:32 +0300
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210051914.35873.lenar@vision.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Couple of days ago I bought Compaq USB keyboard. Although I find the keyboard quite good 
(buttons feel awesome) I must say the idea of buying it was not so good after all.

That's becase I can't get it going under linux correctly. The only way I get it working is in
Boot Protocol Mode, but anyway - don't like this mode, becase I can't use those extra buttons:(

Now, I tried it with usb-uhci.o as well as uhci.o. The net result is the same. No working keyboard.

Below you find kernel messages related to failure.

Basically I'm getting lot of 'usb_control/bulk_msg: timeout' messages and no working keyboard.
I think I got it working one time, but not quite sure about it, because i was quite tired and i haven't 
been able to reproduce the case. Anyway it happened when I enabled 'long timeout for eclipse
upses' config option. It gave me some of those timeout messages and then it started to work. 
After next reboot though - no luck anymore. That time I tried with uhci.o.

Running right now 2.4.20pre8aa2. Please CC me when replying or if you want me to produce 
some additional information about the case.

Lenar

Oct  3 18:23:10 horizon kernel: usb-uhci.c: $Revision: 1.275 $ time 18:14:45 Oct  3 2002
Oct  3 18:23:10 horizon kernel: usb-uhci.c: High bandwidth mode enabled
Oct  3 18:23:10 horizon kernel: usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 11
Oct  3 18:23:10 horizon kernel: usb-uhci.c: Detected 2 ports
Oct  3 18:23:10 horizon kernel: usb.c: new USB bus registered, assigned bus number 1
Oct  3 18:23:10 horizon kernel: hub.c: USB hub found
Oct  3 18:23:10 horizon kernel: hub.c: 2 ports detected
Oct  3 18:23:11 horizon kernel: usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
Oct  3 18:23:11 horizon kernel: usb-uhci.c: Detected 2 ports
Oct  3 18:23:11 horizon kernel: usb.c: new USB bus registered, assigned bus number 2
Oct  3 18:23:11 horizon kernel: hub.c: USB hub found
Oct  3 18:23:11 horizon kernel: hub.c: 2 ports detected
Oct  3 18:23:11 horizon kernel: usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
Oct  3 18:23:11 horizon kernel: usb-uhci.c: Detected 2 ports
Oct  3 18:23:11 horizon kernel: usb.c: new USB bus registered, assigned bus number 3
Oct  3 18:23:11 horizon kernel: hub.c: USB hub found
Oct  3 18:23:11 horizon kernel: hub.c: 2 ports detected
Oct  3 18:23:11 horizon kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Oct  3 18:23:11 horizon kernel: hub.c: new USB device 00:11.2-1, assigned address 2
Oct  3 18:23:11 horizon kernel: Manufacturer: Logitech
Oct  3 18:23:11 horizon kernel: Product: USB Mouse
Oct  3 18:23:11 horizon kernel: usb.c: USB device 2 (vend/prod 0x46d/0xc00c) is not claimed by any active driver.
Oct  3 18:23:11 horizon kernel:   Length              = 18
Oct  3 18:23:11 horizon kernel:   DescriptorType      = 01
Oct  3 18:23:11 horizon kernel:   USB version         = 1.10
Oct  3 18:23:11 horizon kernel:   Vendor:Product      = 046d:c00c
Oct  3 18:23:11 horizon kernel:   MaxPacketSize0      = 8
Oct  3 18:23:11 horizon kernel:   NumConfigurations   = 1
Oct  3 18:23:11 horizon kernel:   Device version      = 6.20
Oct  3 18:23:11 horizon kernel:   Device Class:SubClass:Protocol = 00:00:00
Oct  3 18:23:11 horizon kernel:     Per-interface classes
Oct  3 18:23:11 horizon kernel: Configuration:
Oct  3 18:23:11 horizon kernel:   bLength             =    9
Oct  3 18:23:11 horizon kernel:   bDescriptorType     =   02
Oct  3 18:23:11 horizon kernel:   wTotalLength        = 0022
Oct  3 18:23:11 horizon kernel:   bNumInterfaces      =   01
Oct  3 18:23:11 horizon kernel:   bConfigurationValue =   01
Oct  3 18:23:11 horizon kernel:   iConfiguration      =   00
Oct  3 18:23:11 horizon kernel:   bmAttributes        =   a0
Oct  3 18:23:11 horizon kernel:   MaxPower            =  100mA
Oct  3 18:23:11 horizon kernel:
Oct  3 18:23:11 horizon kernel:   Interface: 0
Oct  3 18:23:11 horizon kernel:   Alternate Setting:  0
Oct  3 18:23:11 horizon kernel:     bLength             =    9
Oct  3 18:23:11 horizon kernel:     bDescriptorType     =   04
Oct  3 18:23:11 horizon kernel:     bInterfaceNumber    =   00
Oct  3 18:23:11 horizon kernel:     bAlternateSetting   =   00
Oct  3 18:23:11 horizon kernel:     bNumEndpoints       =   01
Oct  3 18:23:11 horizon kernel:     bInterface Class:SubClass:Protocol =   03:01:02
Oct  3 18:23:11 horizon kernel:     iInterface          =   00
Oct  3 18:23:11 horizon kernel:     Endpoint:
Oct  3 18:23:11 horizon kernel:       bLength             =    7
Oct  3 18:23:11 horizon kernel:       bDescriptorType     =   05
Oct  3 18:23:11 horizon kernel:       bEndpointAddress    =   81 (in)
Oct  3 18:23:11 horizon kernel:       bmAttributes        =   03 (Interrupt)
Oct  3 18:23:11 horizon kernel:       wMaxPacketSize      = 0004
Oct  3 18:23:11 horizon kernel:       bInterval           =   0a
Oct  3 18:23:12 horizon kernel: hub.c: new USB device 00:11.2-2, assigned address 3
Oct  3 18:23:12 horizon kernel: mice: PS/2 mouse device common for all mice
Oct  3 18:23:12 horizon kernel: Manufacturer: Compaq
Oct  3 18:23:12 horizon kernel: Product: Compaq Internet Keyboard
Oct  3 18:23:12 horizon kernel: usb.c: USB device 3 (vend/prod 0x49f/0xe) is not claimed by any active driver.
Oct  3 18:23:12 horizon kernel:   Length              = 18
Oct  3 18:23:12 horizon kernel:   DescriptorType      = 01
Oct  3 18:23:12 horizon kernel:   USB version         = 1.10
Oct  3 18:23:12 horizon kernel:   Vendor:Product      = 049f:000e
Oct  3 18:23:12 horizon kernel:   MaxPacketSize0      = 8
Oct  3 18:23:12 horizon kernel:   NumConfigurations   = 1
Oct  3 18:23:12 horizon kernel:   Device version      = 1.00
Oct  3 18:23:12 horizon kernel:   Device Class:SubClass:Protocol = 00:00:00
Oct  3 18:23:12 horizon kernel:     Per-interface classes
Oct  3 18:23:12 horizon kernel: Configuration:
Oct  3 18:23:12 horizon kernel:   bLength             =    9
Oct  3 18:23:12 horizon kernel:   bDescriptorType     =   02
Oct  3 18:23:12 horizon kernel:   wTotalLength        = 003b
Oct  3 18:23:12 horizon kernel:   bNumInterfaces      =   02
Oct  3 18:23:12 horizon kernel:   bConfigurationValue =   01
Oct  3 18:23:12 horizon kernel:   iConfiguration      =   02
Oct  3 18:23:12 horizon kernel:   bmAttributes        =   a0
Oct  3 18:23:12 horizon kernel:   MaxPower            =   50mA
Oct  3 18:23:12 horizon kernel:
Oct  3 18:23:12 horizon kernel:   Interface: 0
Oct  3 18:23:12 horizon kernel:   Alternate Setting:  0
Oct  3 18:23:12 horizon kernel:     bLength             =    9
Oct  3 18:23:12 horizon kernel:     bDescriptorType     =   04
Oct  3 18:23:12 horizon kernel:     bInterfaceNumber    =   00
Oct  3 18:23:12 horizon kernel:     bAlternateSetting   =   00
Oct  3 18:23:12 horizon kernel:     bNumEndpoints       =   01
Oct  3 18:23:12 horizon kernel:     bInterface Class:SubClass:Protocol =   03:01:01
Oct  3 18:23:12 horizon kernel:     iInterface          =   03
Oct  3 18:23:12 horizon kernel:     Endpoint:
Oct  3 18:23:12 horizon kernel:       bLength             =    7
Oct  3 18:23:12 horizon kernel:       bDescriptorType     =   05
Oct  3 18:23:12 horizon kernel:       bEndpointAddress    =   81 (in)
Oct  3 18:23:12 horizon kernel:       bmAttributes        =   03 (Interrupt)
Oct  3 18:23:12 horizon kernel:       wMaxPacketSize      = 0008
Oct  3 18:23:12 horizon kernel:       bInterval           =   18
Oct  3 18:23:12 horizon kernel:
Oct  3 18:23:12 horizon kernel:   Interface: 1
Oct  3 18:23:12 horizon kernel:   Alternate Setting:  0
Oct  3 18:23:12 horizon kernel:     bLength             =    9
Oct  3 18:23:12 horizon kernel:     bDescriptorType     =   04
Oct  3 18:23:12 horizon kernel:     bInterfaceNumber    =   01
Oct  3 18:23:12 horizon kernel:     bAlternateSetting   =   00
Oct  3 18:23:12 horizon kernel:     bNumEndpoints       =   01
Oct  3 18:23:12 horizon kernel:     bInterface Class:SubClass:Protocol =   03:01:00
Oct  3 18:23:12 horizon kernel:     iInterface          =   04
Oct  3 18:23:12 horizon kernel:     Endpoint:
Oct  3 18:23:12 horizon kernel:       bLength             =    7
Oct  3 18:23:12 horizon kernel:       bDescriptorType     =   05
Oct  3 18:23:12 horizon kernel:       bEndpointAddress    =   82 (in)
Oct  3 18:23:12 horizon kernel:       bmAttributes        =   03 (Interrupt)
Oct  3 18:23:12 horizon kernel:       wMaxPacketSize      = 0006
Oct  3 18:23:12 horizon kernel:       bInterval           =   03
Oct  3 18:23:12 horizon kernel: usb.c: registered new driver hid
Oct  3 18:23:12 horizon kernel: input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
Oct  3 18:23:12 horizon kernel: input1: USB HID v1.00 Keyboard [Compaq Compaq Internet Keyboard] on usb1:3.0
Oct  3 18:23:12 horizon kernel: usb-uhci.c: interrupt, status 2, frame# 1646
Oct  3 18:23:12 horizon kernel: usb.c: registered new driver keyboard
Oct  3 18:23:15 horizon kernel: usb_control/bulk_msg: timeout
Oct  3 18:23:40 horizon last message repeated 7 times


