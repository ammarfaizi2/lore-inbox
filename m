Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSDSPoD>; Fri, 19 Apr 2002 11:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSDSPoC>; Fri, 19 Apr 2002 11:44:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40719 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312612AbSDSPoC>; Fri, 19 Apr 2002 11:44:02 -0400
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
To: cioby@lnx.ro (Dumitru Ciobarcianu)
Date: Fri, 19 Apr 2002 17:01:38 +0100 (BST)
Cc: davej@suse.de (Dave Jones), jslupski@email.com (Jan Slupski),
        linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <1019229009.1928.24.camel@LNX.iNES.RO> from "Dumitru Ciobarcianu" at Apr 19, 2002 06:10:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yapO-0007Jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 46 structures occupying 1369 bytes.
> DMI table at 0x0FFF0000.
> dmi: read: Success
> read: Illegal seek
> 
> And keeps repeating...
> 
> Any hint why?

Not sure. For some reason the read at 0x0fffffff was failed by the kernel
