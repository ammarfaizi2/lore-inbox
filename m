Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJMRHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJMRHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 13:07:11 -0400
Received: from molly.vabo.cz ([160.216.153.99]:61704 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S261782AbTJMRHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 13:07:08 -0400
Date: Mon, 13 Oct 2003 19:06:49 -0400 (EDT)
From: Tomas Konir <moje@vabo.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7 USB and Palm Tungsten problem 
Message-ID: <Pine.LNX.4.58.0310131855060.2551@moje.vabo.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
I tried 2.6.0-test7, but new USB problem found. I tried to synchronize the 
palm Tungsten T over USB cradle. None happend, only short message about 
palm connected in log. Plug out the palm, but the visor module remained 
busy (count=1) and when i tried to rmmod uhci-hcd the rmmod stay in D 
state.

	MOJE


Loaded modules:

visor
usbserial
uhci-hcd
usbcore

end of dmesg:
only last important lines (i hope)

usbserial 1-1:1.0: usb_probe_interface
usbserial 1-1:1.0: usb_probe_interface - got id
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
Clie 3.5
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
hub 1-0:1.0: port 2, status 101, change 1, 12 Mb/s
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:1.0: new USB device on port 2, assigned address 3
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=5
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 1-2: Product: Palm Handheld
usb 1-2: Manufacturer: Palm, Inc.
usb 1-2: SerialNumber: 303054465042503241434B48
usb 1-2: registering 1-2:1.0 (config #1, interface 0)
usbserial 1-2:1.0: usb_probe_interface
usbserial 1-2:1.0: usb_probe_interface - got id



-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

