Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbULOPDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbULOPDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbULOPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:03:17 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:47372 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S262355AbULOPDL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:03:11 -0500
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc3-mm1 on a EPIA CL-6000 gives weird eth1 messages... (additional info)
Date: Wed, 15 Dec 2004 16:03:06 +0100
Message-ID: <000001c4e2b7$2fb79730$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: High
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's some additional info on my post 2.6.10-rc3-mm1 on a EPIA CL-6000
gives weird eth1 messages.
It's a VIA EPIA CL-6000 with this ethernet hardware:

via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
PCI: Found IRQ 11 for device 0000:00:0f.0
PCI: Sharing IRQ 11 with 0000:00:10.3
eth0: VIA Rhine III at 0xde000000, 00:40:63:d6:40:a7, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
PCI: Found IRQ 9 for device 0000:00:12.0
PCI: Sharing IRQ 9 with 0000:00:10.0
PCI: Sharing IRQ 9 with 0000:00:11.1
eth1: VIA Rhine II at 0xde002000, 00:40:63:d6:40:75, IRQ 9.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.

Eth1 is connected to an alcatel speedtouch home, yielding these messages
once in a while:

Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x2 length 0 status 00000600!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd020 vs
c74dd020.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x3 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd030 vs
c74dd030.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x4 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd040 vs
c74dd040.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x5 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd050 vs
c74dd050.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x6 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd060 vs
c74dd060.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x7 length 7840 status 1ea08d10!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd070 vs
c74dd070.

How can I check if it is a bug or hardware?


