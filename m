Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130372AbQKAURw>; Wed, 1 Nov 2000 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbQKAURm>; Wed, 1 Nov 2000 15:17:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129713AbQKAURd>; Wed, 1 Nov 2000 15:17:33 -0500
Subject: Re: 2.2.18p18 eepro100 issues (packets per irq, shared irqs)
To: pc_pimp@hotmail.com (KJ Pickett)
Date: Wed, 1 Nov 2000 20:18:15 +0000 (GMT)
Cc: eepro100@scyld.com, linux-kernel@vger.kernel.org
In-Reply-To: <F14h29cM3oryKFRJrzd00005763@hotmail.com> from "KJ Pickett" at Nov 01, 2000 07:35:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r4Kv-0000nC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They share an irq, no matter if I'm using intels e100.o driver or the stock 
> linux one.  For performance reasons, can I make them each have a different 
> irq?  Doing it from ifconfig gives me a notsupported error, with either 
> driver.

Under 2.2 no. Under 2.4 maybe

> no kernel hacker...can I get the stock linux driver to do multiple packets 
> per irq with some config settings?

We dont have sufficient docs to figure this out easily. Intel upload magic
numbers to the card microcode
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
