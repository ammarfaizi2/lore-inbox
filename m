Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266201AbRGESek>; Thu, 5 Jul 2001 14:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbRGESea>; Thu, 5 Jul 2001 14:34:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56331 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266195AbRGESeV>; Thu, 5 Jul 2001 14:34:21 -0400
Subject: Re: [PATCH] RE: 2.4.5-ac14 through to 2.4.6-ac1 fdomain.c initialisation for shared IRQ
To: tao@acc.umu.se (David Weinehall)
Date: Thu, 5 Jul 2001 19:34:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), grant@aerodeck.prestel.co.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010705202605.B27854@khan.acc.umu.se> from "David Weinehall" at Jul 05, 2001 08:26:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IDx0-00036c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A.	Check bit 0 of the status port and return 
> > 
> > B.	Check bit 4 or bit 9 of the interrupt control register
> > 
> > Without docs someone would need to play with the various combinations and
> > see what happened
> 
> Uhmmm, an idea would be to look in fd_mcs.c as that driver already has
> working support for irq-sharing.

Doh. 

Ok that indeed shows you check bit 0 if the status port.

Right I'll add shared IRQ support to that driver


