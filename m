Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUBQG4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBQG4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:56:14 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59662 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266097AbUBQG4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:56:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Carl Thompson <cet@carlthompson.net>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
Date: Tue, 17 Feb 2004 08:54:22 +0200
X-Mailer: KMail [version 1.4]
Cc: cet@carlthompson.net
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
In-Reply-To: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 07:41, Carl Thompson wrote:
> 1. Use a wireless network adapter plugged into the PC-Card slot
>
> and
>
> 2. Output sound via the sound card
................
> * I have attached the output of "dmesg" and "lspci -v" to this message.
>
> Carl Thompson

0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Flags: bus master, medium devsel, latency 64, IRQ 11
0000:00:0a.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Flags: bus master, medium devsel, latency 168, IRQ 10
0000:00:0d.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
0000:00:0d.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 64, IRQ 11
0000:00:0d.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Flags: medium devsel, IRQ 11
0000:00:0e.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Flags: bus master, fast devsel, latency 64, IRQ 11
0000:02:00.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev 02)
	Flags: bus master, fast devsel, latency 168, IRQ 10

Your box share IRQs in a big way :)
-- 
vda
