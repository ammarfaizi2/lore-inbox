Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJVIqZ>; Tue, 22 Oct 2002 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSJVIqZ>; Tue, 22 Oct 2002 04:46:25 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:54656 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262291AbSJVIqY> convert rfc822-to-8bit; Tue, 22 Oct 2002 04:46:24 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: USB mouse does not apear in /dev/input
Date: Tue, 22 Oct 2002 10:46:46 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210221046.46700.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm just doing my part in getting the new kernel stable

kernel:	linux-2.5.43
hardware:DELL Inspiron 8100
mouse:	Logitech USB Optical Mouse
config:
		CONFIG_INPUT_MOUSEDEV
		CONFIG_INPUT_EVDEV
		CONFIG_SERIO
		CONFIG_SERIO_I8042
		CONFIG_INPUT_MOUSE
		CONFIG_MOUSE_PS2
		CONFIG_USB
		CONFIG_USB_HID
		CONFIG_USB_HIDINPUT

/dev/input/mice and /dev/input/mouse0 exist and are used for my internal PS/2 
mouse.

dmesg shows that USB mouse exists, and also shows insert and removes 
correctly.

However no /dev/input/mouse1 apears nor do events for this mouse apear on 
/dev/input/mice.

Thanks,
	Take

-- 
Take Vos <Take.Vos@binary-magic.com>
GnuPG: 2A5C110609995A378302A27630C962CCFD54AA85
http://binary-magic.com/~takev/

