Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWJET76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWJET76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWJET76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:59:58 -0400
Received: from mail.polish-dvd.com ([69.222.0.225]:33675 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1751117AbWJET75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:59:57 -0400
Message-ID: <20061005143237.xr08e3ew5b2ocgc8@69.222.0.225>
Date: Thu, 05 Oct 2006 14:32:37 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de
Subject: 2.6.19-rc1 SMP x86_64 boot hungs up
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19-rc1 SMP x86_64 boot hungs up

boot hungs up !!!
last lines from screen at boot time:

...
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ hungs up here
next lines are from working 2.6.18-git6 looks like i8042 problem

PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP cubic registered
...

last good is 2.6.18-git6
2.6.18-git7 to 2.6.19-rc1 hungs up

xboom
art@usfltd.com
