Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274146AbRISTWP>; Wed, 19 Sep 2001 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274143AbRISTVe>; Wed, 19 Sep 2001 15:21:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274142AbRISTVY>; Wed, 19 Sep 2001 15:21:24 -0400
Subject: Re: 2.4.10pre12 -- PPP compile problem;  tty_register_ldisc hanging
To: markorr@intersurf.com (Mark Orr)
Date: Wed, 19 Sep 2001 20:26:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010919064634.6d9cb22d.markorr@intersurf.com> from "Mark Orr" at Sep 19, 2001 06:46:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jmz5-0003c8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just compiled up 2.4.10pre12 (w/ the wakeup_bdflush fix)
> and once modules are finished, on install+depmod it's telling
> me that ppp_async.c has an unresolved symbol
> tty_register_ldisc.
> 
> The pre12 patch shows it was removed from an EXPORT_SYMBOL
> line in net/netsyms.c.

The tty exports are now in the drivers/char/tty* files. 
