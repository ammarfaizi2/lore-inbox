Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbRCHW5u>; Thu, 8 Mar 2001 17:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130129AbRCHW5l>; Thu, 8 Mar 2001 17:57:41 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:32592 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130126AbRCHW5V>; Thu, 8 Mar 2001 17:57:21 -0500
Date: Thu, 8 Mar 2001 22:59:17 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: ES1371 driver in kernel 2.4.2
Message-ID: <Pine.LNX.4.33.0103082255560.11750-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am still having problems with this driver.

When loading the driver I get:

es1371: version v0.27 time 00:47:56 Mar  7 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
PCI: Found IRQ 10 for device 00:0b.0
es1371: found es1371 rev 8 at io 0xa400 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
spurious 8259A interrupt: IRQ7.

This last line seems strange as /proc/interrupts does not list IRQ7:

  0:    2515137          XT-PIC  timer
  1:      18752          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:    2438600          XT-PIC  serial
  5:          0          XT-PIC  bttv
  8:          1          XT-PIC  rtc
 10:          0          XT-PIC  es1371
 12:     310926          XT-PIC  PS/2 Mouse
 14:     137157          XT-PIC  ide0
 15:      35714          XT-PIC  ide1
NMI:          0
ERR:          1

The chip is actually a Cirrus Logic CS4297A.


