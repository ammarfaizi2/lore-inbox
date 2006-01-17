Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWAQROf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWAQROf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWAQROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:14:35 -0500
Received: from main.gmane.org ([80.91.229.2]:3545 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932204AbWAQROe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:14:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: victorhom <homchenko@ixx.ru>
Subject: Re: [PATCH 25/25] Added remote control support for pinnacle pctv
Followup-To: gmane.comp.video.video4linux
Date: Tue, 17 Jan 2006 23:58:52 +0300
Message-ID: <dqj7nl$8db$1@sea.gmane.org>
References: <20060116091105.PS83611600000@infradead.org> <20060116091126.PS06106100025@infradead.org>
Reply-To: homchenko@ixx.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.255.143.13
User-Agent: KNode/0.9.2
Cc: Video4linux-list@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote
> 
> From: Markus Rechberger <mrechberger@gmail.com>
> 
Hi, Markus!

Remote control is not working, sorry :(

# cat /etc/modprobe.d/tv
options em28xx tuner=63 ir_debug=1 i2c_scan=1 i2c_debug=1
options tuner secam=d pal=d

# modprobe em28xx
# modprobe ir-kbd-i2c
# dmesg

tveeprom: module not supported by Novell, setting U taint flag.
ir_common: module not supported by Novell, setting U taint flag.
em28xx: module not supported by Novell, setting U taint flag.
em28xx v4l2 driver version 0.0.1 loaded
em28xx new video device (2304:0208): interface 0, class 255
em28xx: Alternate settings: 8
em28xx: Alternate setting 0, max size= 0
em28xx: Alternate setting 1, max size= 1024
em28xx: Alternate setting 2, max size= 1448
em28xx: Alternate setting 3, max size= 2048
em28xx: Alternate setting 4, max size= 2304
em28xx: Alternate setting 5, max size= 2580
em28xx: Alternate setting 6, max size= 2892
em28xx: Alternate setting 7, max size= 3072
saa711x: module not supported by Novell, setting U taint flag.
saa711x: Ignoring new-style parameters in presence of obsolete ones
tuner: module not supported by Novell, setting U taint flag.
tda9887: module not supported by Novell, setting U taint flag.
attach_inform: saa7113 detected.
tuner 0-0063: chip found @ 0xc6 (em28xx #0)
attach inform: detected I2C address c6
tuner 0-0063: type set to 63 (Philips FMD1216ME MK3 Hybrid Tuner)
tda9887 0-0043: chip found @ 0x86 (em28xx #0)
em28xx #0: i2c eeprom 00: 1a eb 67 95 04 23 08 02 10 00 1e 03 98 2a 6a 2e
em28xx #0: i2c eeprom 10: 00 00 06 57 6e 00 00 00 8e 00 00 00 07 00 00 00
em28xx #0: i2c eeprom 20: 16 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 30: 00 00 20 40 20 80 02 20 10 01 00 00 00 00 00 00
em28xx #0: i2c eeprom 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 60: 00 00 00 00 00 00 00 00 00 00 2e 03 50 00 69 00
em28xx #0: i2c eeprom 70: 6e 00 6e 00 61 00 63 00 6c 00 65 00 20 00 53 00
em28xx #0: i2c eeprom 80: 79 00 73 00 74 00 65 00 6d 00 73 00 20 00 47 00
em28xx #0: i2c eeprom 90: 6d 00 62 00 48 00 00 00 2a 03 50 00 43 00 54 00
em28xx #0: i2c eeprom a0: 56 00 20 00 55 00 53 00 42 00 32 00 20 00 50 00
em28xx #0: i2c eeprom b0: 41 00 4c 00 2f 00 53 00 45 00 43 00 41 00 4d 00
em28xx #0: i2c eeprom c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom f0: 00 00 00 00 00 00 00 00 0c 22 17 38 02 90 2b 3e
EEPROM ID= 0x9567eb1a
Vendor/Product ID= 2304:0208
AC97 audio (5 sample rates)
500mA max power
Table at 0x06, strings=0x2a98, 0x2e6a, 0x0000
em28xx #0: found i2c device @ 0x4a [saa7113h]
em28xx #0: found i2c device @ 0x86 [tda9887]
em28xx #0: found i2c device @ 0x8e [remote IR sensor]
em28xx #0: found i2c device @ 0xa0 [eeprom]
em28xx #0: found i2c device @ 0xc6 [tuner (analog)]
em28xx #0: V4L2 device registered as /dev/video0
em28xx #0: Found Pinnacle PCTV USB 2
usbcore: registered new driver em28xx
ir_kbd_i2c: module not supported by Novell, setting U taint flag.
attach_inform: IR detected ().
ir-kbd-i2c: i2c IR (EM28XX Pinnacle PCTV) detected at i2c-0/0-0047/ir0
[em28xx #0]
i2c IR (EM28XX Pinnacle PCTV)/ir: key 00
i2c IR (EM28XX Pinnacle PCTV): unknown key: key=0x00 raw=0x00 down=1
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV): unknown key: key=0x00 raw=0x00 down=0
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
...
...

>From /var/log/messages:

Jan 17 23:51:30 6-199 kernel: i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
Jan 17 23:52:01 6-199 last message repeated 301 times
Jan 17 23:53:02 6-199 last message repeated 610 times
Jan 17 23:54:03 6-199 last message repeated 609 times
Jan 17 23:55:04 6-199 last message repeated 610 times
...

These 'key 3f' are received without touching any bytton on the remote.
Pressing any key some times sometimes ( sorry my english :) turn a key UP
(3f from your table).

That's all.

-- 
Victor Homchenko

