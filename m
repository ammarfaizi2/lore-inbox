Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSEYP0t>; Sat, 25 May 2002 11:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314675AbSEYP0s>; Sat, 25 May 2002 11:26:48 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:58841 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S314682AbSEYP0r>; Sat, 25 May 2002 11:26:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: USB Keyboard problem
Date: Sat, 25 May 2002 18:26:42 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205251826.42386.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just bought an "HP Multimedia Keyboard Hub" (USB).
Using with RedHat 7.2, kernels 2.4.9-81 and also
various 2.4.19-pre.

Immediately after boot the keyboard does not work.
I see some events from the knob and also from
some extra buttons but not from the keyboard itself
(some produce "unknown scancode" errors. That's
a different topic). The keyboard leds turn on and off
responding to pressing caps-lock etc on the PS/2
keyboard.

After "rmmod hid" and "modprobe hid" The usb
keyboard works just fine - until I disconnect/reconnect
it or until the next reboot.

The hub function on they keyboard works OK.

The keyboard works with other OS, or with the bios
(after I enabled "USB Legasy Support").

Any suggestions/hints?

I'm also looking for programs o test the HID event
interface (evtest) as suggested in the docs, It is not in
the suggested web page.

Thanks,

-- Itai

