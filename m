Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTHSUzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbTHSUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:54:45 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:4588 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261403AbTHSUyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:54:10 -0400
Message-ID: <3F428E5C.80801@myrealbox.com>
Date: Tue, 19 Aug 2003 13:53:48 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Broadcom gigabit ethernet question for Jeff?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, it's me again.  Sorry to be back, but 2.6 is looming and I still have the
same old problem with my Asus A7V8X with builtin Broadcom chip.

If you'll recall I must do an ifconfig down/up cycle to get the chip to transmit
any packets.  Once I do that the chip works fine until the next reboot.  See lkml
archives for March 5.

This problem first appeared in 2.4.21-rc5.  Before that the chip worked fine for me.

All I can offer is below.  I'll be happy to do any debugging you wish, but I will
need explicit help.  I'm no expert at kernel debugging.

00:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a9
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
         Memory at f1800000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at f7ff0000 [disabled] [size=64K]
         Capabilities: [40] PCI-X non-bridge device.
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:d2:a6:c1

If there is some way of dumping the 'state' of the chip before and after doing the
ifconfig down/up it might be a valuable clue.  I just don't know how to do it.

