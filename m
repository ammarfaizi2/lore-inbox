Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753242AbWKCLrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbWKCLrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbWKCLrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:47:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753242AbWKCLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:47:54 -0500
Subject: Re: irqpoll kernel option hurts performance?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xp newbie <xp_newbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103053737.78243.qmail@web38407.mail.mud.yahoo.com>
References: <20061103053737.78243.qmail@web38407.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Nov 2006 11:52:04 +0000
Message-Id: <1162554724.12810.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 21:37 -0800, ysgrifennodd xp newbie:
> specified the "irqpoll" option to boot the installation CD, is the
> system doomed to always work in "IRQ polling mode" (which is much more
> CPU wasteful if I understand this correctly)? Am I really using my
> hardware now in less than optimal manner (like in PIO vs. DMA, for
> example)?

irqpoll has a small impact, how big depends what the box does (on a
gigabit network firewall its bad news, on a typical desktop its not
measurable).

IRQ problems of the form you report can arise from a couple of places -
one is vendors getting IRQ routing tables wrong (suprisingly common),
the other may be a Linux bug.

Checking for a BIOS update may therefore be useful. 

Is this a VIA chipset machine ?

Alan

