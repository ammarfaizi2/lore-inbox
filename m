Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbREaJbF>; Thu, 31 May 2001 05:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263041AbREaJap>; Thu, 31 May 2001 05:30:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263043AbREaJal>; Thu, 31 May 2001 05:30:41 -0400
Subject: Re: 2.4.5 -ac series broken on Sparc64
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 31 May 2001 10:28:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lsawyer@gci.com (Leif Sawyer),
        linux-kernel@vger.kernel.org (linux kernel mailinglist)
In-Reply-To: <20010531102113.A17090@flint.arm.linux.org.uk> from "Russell King" at May 31, 2001 10:21:13 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155Okr-0007IH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In Linus' tree, the only reference outside arch code to linux/irq.h is:
> 
> drivers/pcmcia/hd64465_ss.c:#include <linux/irq.h>
> 
> and it'd be good to get rid of that one as well, but AFAICS this is a
> sh specific driver.

Yep

> Please, lets not make it compulsary for architectures to implement the irq
> handling described in linux/irq.h.

Seems reasonable
