Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274154AbRISUBP>; Wed, 19 Sep 2001 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274156AbRISUBG>; Wed, 19 Sep 2001 16:01:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17156 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274154AbRISUAz>; Wed, 19 Sep 2001 16:00:55 -0400
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
To: greearb@candelatech.com (Ben Greear)
Date: Wed, 19 Sep 2001 21:05:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bruce@ask.ne.jp (Bruce Harada),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BA8F7BB.273734EA@candelatech.com> from "Ben Greear" at Sep 19, 2001 12:53:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jnal-0003kR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Damn..someone has to make good stable motherboards...anyone got any
> suggestions for one that will fit into a 1U server, with built-in
> Video and preferably a NIC?  I had ok luck with an Intel board based
> on the 815 chipset, so long as I used the e100 driver...maybe I'll
> have to go back to it...

The 815 + e100 thing is _not_ a hardware issue. Its some subtle driver
related things, and of course Intel are keen to push e100 rather than
help people fix the kernel driver so not much help.

I've fixed some of the problems in recent -ac (the power management timeout)
which is now in Linus tree. Arjan van de Ven also fixed some other bits.

I'd be interested to know if that helps (to keep the test simple and single
variable you can use the -ac eepro100.c file in Linus 2.4.9)

Alan
