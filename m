Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUBVNk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 08:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUBVNk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 08:40:56 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:48877 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261247AbUBVNkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 08:40:55 -0500
Subject: kernel: NETDEV WATCHDOG: eth0: transmit timed out
From: Sven Dowideit <svenud@ozemail.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077457080.1208.17.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 00:38:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM thinkpad T21 that has a 3Com ethernet card that has not
been working in a long while (with ACPI turned on).

Recently (the last 2-3 releases or so) it has also been getting the
following messages (until i remember to to an ifconfgi eth0 down)

Feb 23 00:22:00 sven kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb 23 00:22:35 sven last message repeated 3 times
Feb 23 00:23:35 sven last message repeated 5 times
Feb 23 00:24:35 sven last message repeated 5 times
Feb 23 00:25:35 sven last message repeated 5 times
Feb 23 00:26:00 sven last message repeated 2 times


the other weird thing, is that my computer pauses every few seconds, for
a second, and it seems like this symptom goes away after the ifconfig
down. 


any ideas?

cheers

Sven

------------------------------------------------------------------
00:03.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus
(rev 20)
        Subsystem: 3Com Corporation: Unknown device 6356
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 1800 [size=256]
        [virtual] Memory at e8101400 (32-bit, non-prefetchable)
[size=128]
        [virtual] Memory at e8101000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2


eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:21 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0x1800 


