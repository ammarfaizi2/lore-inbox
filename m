Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282188AbRKWQyZ>; Fri, 23 Nov 2001 11:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282191AbRKWQyQ>; Fri, 23 Nov 2001 11:54:16 -0500
Received: from h201.p490.iij4u.or.jp ([210.149.234.201]:54673 "EHLO
	rai.sytes.net") by vger.kernel.org with ESMTP id <S282188AbRKWQyH> convert rfc822-to-8bit;
	Fri, 23 Nov 2001 11:54:07 -0500
Message-Id: <200111231654.fANGs0705731@rai.sytes.net>
Content-Type: text/plain;
  charset="iso-2022-jp"
From: Tetsuji Rai <tetsuji@rai.sytes.net>
To: linux-kernel@vger.kernel.org
Subject: bttv module intialization takes much time on kernel-2.4.x
Date: Sat, 24 Nov 2001 01:54:00 +0900
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Title says it all.  I use bttv module.   When invoking "modprobe bttv" it 
takes several minutes to initialize.  When I used kernel-2.2.x it was very 
quick, but with kernel-2.4.x it takes a while.   But after that, it works 
fine.
   I don't know why.  Any solutions??  or am I doing anything wrong?
For your reference, I use BT878 based card, kernel-2.4.15-pre8 for now and 
dmesg gives these messages:
----snip----snip-----
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.83 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge is Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub
bttv: Bt8xx card found (0).
PCI: Found IRQ 5 for device 02:05.0
PCI: Sharing IRQ 5 with 02:05.1
bttv0: Bt878 (rev 17) at 02:05.0, irq: 5, latency: 32, memory: 0xe0000000
bttv0: using: BT878( *** UNKNOWN/GENERIC **) [card=0,autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
------snip-----snip------
TIA

-- 
Tetsuji Rai (in Tokyo)
http://www.geocities.com/tetsuji_rai
Fax: +1-708-570-4868 (in the US)
