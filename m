Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUIEJxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUIEJxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 05:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUIEJxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 05:53:20 -0400
Received: from web8504.mail.in.yahoo.com ([202.43.219.166]:28087 "HELO
	web8504.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S266477AbUIEJxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 05:53:16 -0400
Message-ID: <20040905095313.42297.qmail@web8504.mail.in.yahoo.com>
Date: Sun, 5 Sep 2004 10:53:13 +0100 (BST)
From: =?iso-8859-1?q?Dinesh=20Ahuja?= <mdlinux7@yahoo.co.in>
Subject: Mouse Support in Kernel 2.6.8
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have build and installed Kernel 2.6.8 in my machine
which has Red Hat Linux 9.0 installed. The mouse
[Logitech Mouse with 3 buttons] supports works fine in
Red Hat Linux 9.0 but it is not detected by Kernel
2.6.8. I have modified the rc.sysinit and halt scripts
as suggested by some articles posted on the net. I
have included USB support and have usbmose, usbkdb,
usbcore and uhci-hcd modules loaded at the time of
booting kernel 2.6.8. 

Please guide me how to proceed to provide the mouse
support in my kernel 2.6.8.

My configuration file is as follows:
#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m

I have spend two days on it and looking for the help
to find the solution of this problem.

Regards
Dinesh




________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
