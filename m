Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTK2XFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 18:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTK2XFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 18:05:32 -0500
Received: from smtp-2.hut.fi ([130.233.228.92]:64461 "EHLO smtp-2.hut.fi")
	by vger.kernel.org with ESMTP id S261460AbTK2XFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 18:05:31 -0500
Date: Sun, 30 Nov 2003 01:05:29 +0200 (EET)
From: Matti Kleemola <mkleemol@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Is SATA working? (Can I use sw.raid-5 with SATA + ATA drives?)
Message-ID: <Pine.LNX.4.58.0311300024450.4029@bach.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-2.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need a new motherboard and I have to decide should I buy
Epox PE-4PCA3+ (and use 3 ATA drives connected to HPT374) or
Asus P4C800E-Deluxe (and use 1(2) SATA drive and 2(1) ATA drives).

Board from Asus is about 5% faster in every zone (tomshardware.com)
but can I make it work?
In Asus there is unfortunately only 3 ATA connectors (one is needed
for CD-RW) and I'm not going to put 2 drives on the same cable.

I understood that there are some problems with promise 20378 used in
Asus (in 64 bit mode). Is that something I need to worry about?

Here are chips used in those boards:
 Chipset (both boards):
  Intel 875P + ICH5R

 Asus:
  Promise 20378 raid
  Intel 82547 lan
  Soundmax

 Epox:
  HPT374 raid
  BCM5705 / 5788 lan
  cmi9739A (sounds)

If network or soundsystem is not working rightaway it's not a problem
cause I still have working PCI-cards. If disks are working that's enough
for a while. I'm sure that sound and networks chips will also work on some
day.

Asus have also other very interesting board (P4P800-Deluxe) but it uses
VIA 6410 as a raid controlled and I understood that it's not working (and
VIA is not going to support opensource.. :( ). With that board I could use
ATA drives (4 connectors, two of them coming from VIA6410). It would be
almost as fast as P4C800.

ps. I'm just an ordinary home user and I don't understand any details.

Thanks,
Matti ..with great (but broken) Abit KT7-RAID
