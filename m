Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDUJt6>; Sat, 21 Apr 2001 05:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDUJts>; Sat, 21 Apr 2001 05:49:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132552AbRDUJti>; Sat, 21 Apr 2001 05:49:38 -0400
Subject: Re: SMP in 2.4
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Sat, 21 Apr 2001 10:50:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dennis@etinc.com (Dennis),
        matti.aarnio@zmailer.org (Matti Aarnio), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010421110704.25023A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Apr 21, 2001 11:08:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qu25-0003M3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > especially if you want to do it right on the BX. But you can do this and rtlinux
> > does
> 
> There is already desc->handler->ack(irq) in do_IRQ which does that. Is any
> more special handling needed? 

You need to keep the IRQ line masked not just ack it. The code for handling all
the BX and other cases is there but its a bit more than 3 clock cycles long


