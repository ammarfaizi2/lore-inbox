Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQKBJTY>; Thu, 2 Nov 2000 04:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129420AbQKBJTE>; Thu, 2 Nov 2000 04:19:04 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:39496 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129255AbQKBJTA>;
	Thu, 2 Nov 2000 04:19:00 -0500
Date: Thu, 2 Nov 2000 11:26:18 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2.18pre19
Message-ID: <Pine.LNX.4.10.10011020931280.8444-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Seems like something in USB went wrong from pre15, I get something like
what is in the attachment.

I have tried using HID + mouse, HID BP, disabling event interface,
disabling hot-plug support, disabling  preliminary USB fs, disabling
bandwidth allocation, the effect are still the same even is leaving there
only the basic stuff:

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
# CONFIG_USB_DEVICEFS is not set
# CONFIG_HOTPLUG is not set
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI=y
# CONFIG_USB_OHCI is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=y
# CONFIG_USB_WACOM is not set
# CONFIG_USB_WMFORCE is not set
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

Any more info, I could send?

Fixing this would be very much appreciated, because this would be my first
2.2 kernel with all ide, raid, usb and nfs patches working properly at the
same time. Maybe even VM beheaves now... ;) (I used to have the
do_try_to_free_page for XXX hang even w/ pre15).

--  SaPE

Peter, Sasi <sape@sch.hu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
