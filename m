Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJQKTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTJQKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:19:41 -0400
Received: from sea2-dav51.sea2.hotmail.com ([207.68.164.40]:38157 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263369AbTJQKTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:19:31 -0400
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3C905 + options=0x8
Date: Fri, 17 Oct 2003 12:19:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV51Yzr7Oq4mm00004830@hotmail.com>
X-OriginalArrivalTime: 17 Oct 2003 10:19:29.0466 (UTC) FILETIME=[264769A0:01C39498]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me again.
This is the dmesg after doing "modprobe 3c59x options=0x8 debug=7"

PCI: Found IRQ 10 for device 00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0f.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xe400. Vers LK1.1.18-ac
 00:60:97:d8:e5:01, IRQ 10
  product code 4848 rev 00.0 date 04-28-97
  Internal config register is 102001b, transceivers 0xe040.
  64K word-wide RAM 1:1 Rx:Tx split, autoselect/10baseT interface.
00:0f.0:  Media override to transceiver type 8 (Autonegotiate).
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:0f.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
eth0:  Filling in the Rx ring.
eth0: Media override to transceiver 8 (Autonegotiate).
eth0: Initial media type Autonegotiate.
vortex_up(): writing 0x18302d8 to InternalConfig
eth0: MII #24 status 786d, link partner capability 0021, info1 0020,
setting half-duplex.
eth0: vortex_up() InternalConfig 018302d8.
eth0: vortex_up() irq 10 media status 8a10.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: Media selection timer finished, Autonegotiate.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 0.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 1.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 3 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 2.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 3.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 4.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 5.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 6.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 7.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 8.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 9.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 10.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 11.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 12.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 13.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 14.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 15.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 16.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()

This nic doesn't send/receive any packet. Any idea?
PS: Same thing with linux-2.6.0test7
