Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRHMMRz>; Mon, 13 Aug 2001 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHMMRp>; Mon, 13 Aug 2001 08:17:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21508 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270133AbRHMMRa>; Mon, 13 Aug 2001 08:17:30 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Mon, 13 Aug 2001 13:19:01 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Paul G. Allen" at Aug 12, 2001 06:33:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WGgP-0007HO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, if you followed the other thread on the Tyan Thunder lockup,
> > you'll have noticed that it locked up under heavy PCI loads. At least on
> > that machine it stopped with the 2.4.8 driver.

No it merely made them less common. I think thats unrelated. Early AMD
chips had bugs, and the SB Live! is famous for triggering PCI bugs because
of the very unusual and tight PCI access patterns it generates - it was
the main trigger for the via audio corruption too (and the AMD chipset
shares common ancestry with the VIA..)

Alan
