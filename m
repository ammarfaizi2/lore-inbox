Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTLTWrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 17:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTLTWrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 17:47:08 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:59852 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261744AbTLTWrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 17:47:06 -0500
To: linux-kernel@vger.kernel.org
Subject: bcm5705 with tg3 driver and high rx load -> bad system
 responsiveness
From: Ronald Wahl <ronald.wahl@informatik.tu-chemnitz.de>
Date: Sat, 20 Dec 2003 23:47:04 +0100
Message-ID: <m27k0rds47.fsf@rohan.middle-earth.priv>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 2.61 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 489ffd0e04f7de08dacf4c0626a7b16e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I just got the 2.6.0 kernel running (without major problems). The
only annoying issue I have is the tg3 network driver. Sending out a
100 MBit/s stream is no problem. Receiving with this speed makes
the system a bit unresponsive. This means the mouse (usb) freezes
now and then for a short period and the system monitor applets from
gnome hanging at the same time too. There are no system messages
that indicate any error. With 2.4.x I used the original driver from
Broadcom (http://www.broadcom.com/drivers/downloaddrivers.php) that
worked without any problem. The tg3 driver in 2.4.23 caused a high
system load on network traffic - maybe this problem is related.  My
system is a Pentium 4 @ 3GHz with Hyperthreading enabled - i.e. 2
logical processors. The mainboard (Epox 4PDA2+) has a bcm 5705
network chip:

02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 01)
        Subsystem: Unknown device 1695:9013
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 21
        Memory at f8000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

Is this issue known? Are there any fixes. Do you need more information?

Thanks,
ron

PS: Keep me in Cc:, please! I'm not on the list. Thanks!
