Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCOJFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCOJFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:05:32 -0500
Received: from hydro.codone.com ([66.111.42.130]:43161 "EHLO canib.us")
	by vger.kernel.org with ESMTP id S262380AbUCOJF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:05:28 -0500
Message-ID: <62956.67.22.138.14.1079363064.squirrel@mail.canib.us>
Date: Mon, 15 Mar 2004 10:04:24 -0500 (EST)
Subject: Multiport Serial Device Support - Exar XR17L154
From: "Christopher Grzegorczyk" <chris@lightpowered.net>
To: linux-kernel@vger.kernel.org
Reply-To: chris@lightpowered.net
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for the repost but it seems that my original message (
http://lkml.org/lkml/2004/3/12/23 ) appeared without the body....


I have failed to find reference to this particular
device anywhere beside Exar:

[1] Exar XR17L154
http://www.exar.com/product.php?ProdNumber=XR17L154&areaID=3
Note: The page indicates that "A Linux driver is also available.", but I
can't seem to get my hands on it. ( Does anyone have it by chance? )

[2] System:
PC104 / Intel PIIX Compatible
16MB CompactFlash
Celeron 1.2Ghz @ 800Mhz
2.4.25 / 2.6.3

I have noted support for the Exar ST16C555/XR16... in char/serial.c,
however, the XR17L154 differs in that it has a 32 bit interface ( linear
addressing ) with all 4 UARTs on the same IRQ.  My attempts to have the
kernel recognize the device have failed.

Is there a chance of having this device work under the stock kernel (
2.4.25 )?

If not, can someone suggest an existing multiport driver which could serve
as a reasonable starting point for development by a kernel newbie?

TIA, greatly appreciated.

Chris

p.s. Please CC in replies as I am not subscribed.
