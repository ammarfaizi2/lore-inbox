Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUL1Saw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUL1Saw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUL1Saw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:30:52 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:26754 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261213AbUL1SaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:30:22 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: kraxel@bytesex.org
Subject: Re: Current saa7134 driver breaks KNC One Tv-Station DVR (card=24)
Date: Tue, 28 Dec 2004 19:28:05 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412281821.53919.bero@arklinux.org>
In-Reply-To: <200412281821.53919.bero@arklinux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200412281928.05898.bero@arklinux.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 December 2004 18:21, Bernhard Rosenkraenzer wrote:
> Trying to modprobe saa7134 with this card results in a hanging modprobe
> process.

Some more debug info (with 2.6.10-ac1):

saa7130/34: v4l2 driver version 0.2.12 loaded
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
saa7134[0]: found at 0000:00:06.0, rev: 1, irq: 177, 
latency: 64, mmio: 0xdfff9c00
saa7134[0]: subsystem: 1894:a006, board: KNC One TV-Station DVR 
[card=24,autodetected]
saa7134[0]: board init: gpio is 830000
saa7134[0]/oss: mixer input = TV
saa7134[0]: i2c xfer: < a0 00 >
saa7134[0]: i2c xfer: < a1 =94 =18 =06 =a0 =06 =80 =00 =01 =00 =00 =00 =00 =00 
=00 =01 =00 =00 =ff =86 =0e =ff =20 =ff =ff =ff =ff =ff =ff =ff =ff =ff =ff 
=01 =40 =01 =02 =02 =03 =01 =03 =06 =ff =01 =df =ff =ff =ff =ff =ff =ff =ff 
=ff =ff =ff =ff =ff =ff =ff =ff =ff =ff =ff =ff =ff >
saa7134[0]: i2c eeprom 00: 94 18 06 a0 06 80 00 01 00 00 00 00 00 00 01 00
saa7134[0]: i2c eeprom 10: 00 ff 86 0e ff 20 ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: 01 40 01 02 02 03 01 03 06 ff 01 df ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]/core: hwinit2
saa7134[0]/video: set tv norm = PAL
saa7134[0]/video: video input = 0 [Television]
saa7134[0]/video: set tv norm = PAL
saa7134: Loading i2c helpers<7>saa7134[0]: i2c xfer: < c0 >
tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
saa7134[0]: i2c xfer: < c2 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < c4 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < c6 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < c8 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < ca ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < cc ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < ce ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < d0 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < d2 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < d4 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < d6 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < d8 ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < da ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < dc ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < de ERROR: NO_DEVICE
saa7134[0]: i2c xfer: < 86 >
tda9885/6/7: chip found @ 0x86
saa7134[0]: i2c xfer: < 86 00 c2 10 00 >
saa7134[0]: i2c xfer: < 96 ERROR: NO_DEVICE
saa7134[0]/irq[0,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[1,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[2,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[3,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[4,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[5,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[6,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[7,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[8,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[9,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq[10,-227141]: r=0x20 s=0x00 PE
saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit
saa7134[0]/irq[0,-227141]: r=0x20 s=0x00 PE
[modprobe hangs]

Looks like it's hanging at request_module("saa7134-empress");
