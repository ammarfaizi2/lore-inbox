Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317465AbSF1RON>; Fri, 28 Jun 2002 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317467AbSF1ROM>; Fri, 28 Jun 2002 13:14:12 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:52205 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317465AbSF1ROM>; Fri, 28 Jun 2002 13:14:12 -0400
Subject: 2.4.19-xx USB-HID Bug ?!?
From: Carsten Rietzschel <cr@daRav.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jun 2002 19:15:47 +0200
Message-Id: <1025284549.5376.10.camel@linux.daR.av>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

after trying the 2.4.19-pre10-ac2 and 2.4.19-rc1 and 2.4.19-gentoo-r7
and also 2.4.19-gentoo-r5,no HID device works !!
(for me it seems, all of them are "derivates" of -ac-Patches, or not ?)

There are only /dev/usb/hid/hidraw0 to hidraw2 and no /dev/input/mouse0

Also it seems thate the kernelmessages says:
  "hiddev0: Logitech USB Mouse on usb1:4.0"
with 2.4.18 or 2.4-19-xx disabled HID and using HIDBP's (basic) it
shows:
    "input2: Logitech USB Mouse on usb1:4.0".


Here's part of my config (all other aren't set):
#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_LONG_TIMEOUT=y

CONFIG_USB_OHCI=y

CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
# CONFIG_USB_HIDINPUT is not set
CONFIG_USB_HIDDEV=y
CONFIG_USB_SCANNER=m



Carsten


