Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133100AbRDRMaY>; Wed, 18 Apr 2001 08:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133104AbRDRMaO>; Wed, 18 Apr 2001 08:30:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133100AbRDRMaE>; Wed, 18 Apr 2001 08:30:04 -0400
Subject: Re: AHA-154X/1535 not recognized any more
To: markus.schaber@student.uni-ulm.de (Markus Schaber)
Date: Wed, 18 Apr 2001 13:31:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3ADD7445.6FD2068E@student.uni-ulm.de> from "Markus Schaber" at Apr 18, 2001 01:02:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pr7J-0004cw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Load the module with isapnp=1. It defaults to not scanning isapnp boards which
> > strikes me as odd. Let me know if that fixes it if so I think I'll tweak the
> > default
> 
> This gives me the following message:
> 
> lunix:/lib/modules/2.4.3# modprobe aha1542 isapnp=1
> /lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: init_module: No such
> device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters

Ok if you use the old style usermode isapnp tools to configure it and then
force aha1542 to use the right io, irq to find it does it then work ?

