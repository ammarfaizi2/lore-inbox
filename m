Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbQJ3OCp>; Mon, 30 Oct 2000 09:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbQJ3OCf>; Mon, 30 Oct 2000 09:02:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31042 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129242AbQJ3OCS>; Mon, 30 Oct 2000 09:02:18 -0500
Subject: Re: PLIP driver in 2.2.xx kernels
To: lnxkrnl@mail.ludost.net
Date: Mon, 30 Oct 2000 14:03:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010301840320.15258-100000@doom.izba.net> from "lnxkrnl@mail.ludost.net" at Oct 30, 2000 06:41:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qFXE-0006uP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It has to bang on the parallel port controller the hard way, there is no
> > useful hardware support on a basic parallel port for the kind of abuse needed
> > for PLIP
> > 
> (sorry for the late reply)
>  I used plip with kernel 1.2.8 and had no problem with it...The machines
> that I'm using now are far superior than the old ones... Why shouldn't it
> work now ? 

The performance hasnt changed. Your fast CPU simply spends longer in a tight
loop between each thing it has to do. There are no interrupts we can use for
the nibble by nibble data sending

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
