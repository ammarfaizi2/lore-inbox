Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKQSA3>; Fri, 17 Nov 2000 13:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbQKQSAJ>; Fri, 17 Nov 2000 13:00:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129211AbQKQSAI>; Fri, 17 Nov 2000 13:00:08 -0500
Subject: Re: VGA PCI IO port reservations
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 17 Nov 2000 17:30:31 +0000 (GMT)
Cc: root@chaos.analogic.com, jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <200011171720.RAA01403@raistlin.arm.linux.org.uk> from "Russell King" at Nov 17, 2000 05:20:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wpLN-0000wv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I can definitely say that if you don't allow access to these "extended"
> VGA ports, BIOSes either enter infinite loops or else terminate without

PCI cards also exist that snoop the ISA bus. Several cards snoop the PCI
transactions that eventually go on to the ISA bus in order to emulate ISA bus
DMA


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
