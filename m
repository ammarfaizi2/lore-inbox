Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbTFXCkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbTFXCkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:40:13 -0400
Received: from lucidpixels.com ([66.45.37.187]:21633 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265633AbTFXCkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:40:10 -0400
Date: Mon, 23 Jun 2003 21:54:17 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Promise ATA/133 TX2 IDE Card - Linux 2.4.x driver problem.
Message-ID: <Pine.LNX.4.56.0306232150120.690@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be too early to speculate, however, I have received no spurious
kernel messages with the first generation Promise ATA/100 board (so far).

I have another motherboard (MSI), with another Promise ATA/133 board
(TX2), which also gives this spurious interrupts.

root@l1:/var/log# grep -i spurious *
syslog.1:Jun 19 10:08:48 l1 kernel: spurious 8259A interrupt: IRQ7.
syslog.2:Jun 12 09:33:07 l1 kernel: spurious 8259A interrupt: IRQ7.
syslog.2:Jun 12 20:03:55 l1 kernel: spurious 8259A interrupt: IRQ7.
syslog.2:Jun 14 06:42:23 l1 kernel: spurious 8259A interrupt: IRQ7.
syslog.2:Jun 14 16:12:37 l1 kernel: spurious 8259A interrupt: IRQ7.
syslog.3:Jun  3 09:27:44 l1 kernel: spurious 8259A interrupt: IRQ7.

Is there a particular problem with the ATA/133 TX2 boards, this
error/problem seems to appear with box (that I've used) with this board
(ATA/133 TX2).

Also, I've used the ATA/100 in another box for about a 2 year period
without a single spurious interrupt message.

This leads me to believe there may be something wrong with the Promise
ATA/133 TX2 driver for Linux?


