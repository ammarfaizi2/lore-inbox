Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270507AbRHHPSd>; Wed, 8 Aug 2001 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270508AbRHHPSX>; Wed, 8 Aug 2001 11:18:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60937 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270507AbRHHPSV>; Wed, 8 Aug 2001 11:18:21 -0400
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
To: jdthoodREMOVETHIS@yahoo.co.uk (Thomas Hood)
Date: Wed, 8 Aug 2001 16:20:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Thomas Hood" at Aug 08, 2001 11:15:15 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UV8M-0005SE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following would seem to be required to protect against
> the case in which PnP BIOS reports an IRQ of 0 for a 
> parport with disabled IRQ.      // Thomas  jdthood_AT_yahoo.co.uk

IRQ 0 is a legal valid IRQ. I suspect the problem is that pnpbios shouldnt
be reporting an IRQ or we should be using some kind of NO_IRQ cookie
