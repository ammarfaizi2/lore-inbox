Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTHYKMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTHYKMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:12:21 -0400
Received: from hireright-gw.online.ee ([194.106.125.50]:57538 "EHLO
	mail.hireright.ee") by vger.kernel.org with ESMTP id S261672AbTHYKLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:11:42 -0400
Date: Mon, 25 Aug 2003 13:11:41 +0300 (EEST)
From: Anton Keks <anton@ns.hireright.ee>
To: linux-kernel@vger.kernel.org
Subject: CardBus card is not recognized (PCI vendor 0xffff, ...)
Message-ID: <Pine.LNX.4.44.0308251308580.24715-100000@ns.hireright.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm stuck with my Trendnet TEW-221PCI wireless lan card (Cardbus) not 
working in Linux... (it works in Windoze 2k). 
Card insertion is detected, but the card itself is not recognized.

I have searched everywhere and I am not able to find any solutution.

Here is what I get in dmesg:
cs: cb_alloc(bus 2): vendor 0xffff, device 0xffff
PCI: device 02:00.0 has unknown header type 7f, ignoring.
PCI: No IRQ known for interrupt pin ? of device 02:00.0

lspci says that the card's vendor is unknown.

cardctl status:
Socket 0:
3.3V CardBus card
function 0: [ready]

cardctl ident:
Socket 0:
no product info available

I have several kernels (RH 9.0 one as well as 2.4.21 and 2.4.22-rc1). 
PCMCIA utilities are pcmcia-cs-3.2.4.

My cardbus controller is detected prefectly (it is made by ENE), machine 
is ECS Green 550.

The card uses ADMtek 8211 chipset (if that matters). 
Unfortunately I don't have other cards to test, but this one works in 
Windows on the same machine...

I don't know if this a bug or something, but I'm really stuck, so any 
advice is appreciated. 
Please CC me when replying if possible.


