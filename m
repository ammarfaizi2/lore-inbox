Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTHYKIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTHYKIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:08:00 -0400
Received: from hireright-gw.online.ee ([194.106.125.50]:48321 "EHLO
	mail.hireright.ee") by vger.kernel.org with ESMTP id S261504AbTHYKH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:07:58 -0400
From: "Anton Keks" <anton@hireright.ee>
To: <linux-kernel@vger.kernel.org>
Subject: CardBus card is not recognized (PCI vendor 0xffff, ...)   
Date: Mon, 25 Aug 2003 13:07:56 +0300
Message-ID: <003501c36af0$c1a0c4e0$7118b4d5@hireright.ee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
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

