Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTF1BJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbTF1BJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:09:09 -0400
Received: from web40610.mail.yahoo.com ([66.218.78.147]:41037 "HELO
	web40610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264975AbTF1BJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:09:05 -0400
Message-ID: <20030628012321.58912.qmail@web40610.mail.yahoo.com>
Date: Fri, 27 Jun 2003 18:23:21 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- drivers/built-in.o(.text+0x5e3f6): In function `hidinput_hid_event': : undefined reference to `input_event'
To: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x5e3f6): In function
`hidinput_hid_event':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x5e7d0): In function
`hidinput_connect':
: undefined reference to `input_register_device'
drivers/built-in.o(.text+0x5e81e): In function
`hidinput_connect':
: undefined reference to `input_register_device'
drivers/built-in.o(.text+0x5e985): In function
`hidinput_disconnect':
: undefined reference to `input_unregister_device'
drivers/built-in.o(.text+0x5e42d): In function
`hidinput_hid_event':
: undefined reference to `input_event'
make: *** [.tmp_vmlinux1] Error 1


#
# USB support
#
CONFIG_USB=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m

# Input device support
#
CONFIG_INPUT=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Input I/O drivers
#
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PCIPS2=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
