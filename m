Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUEJSDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUEJSDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUEJSDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:03:14 -0400
Received: from florence.buici.com ([206.124.142.26]:1420 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261169AbUEJSDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:03:13 -0400
Date: Mon, 10 May 2004 11:03:12 -0700
From: Marc Singer <elf@buici.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sean <seandarcy@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: can't see drive on promise 20375 ATA card
Message-ID: <20040510180312.GC27648@buici.com>
References: <c7hgrq$5bv$1@sea.gmane.org> <409FAB04.5070006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409FAB04.5070006@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 12:17:08PM -0400, Jeff Garzik wrote:
> sean wrote:
> >libata version 1.02 loaded.
> >sata_promise version 0.92
> >ata1: SATA max UDMA/133 cmd 0xE1863200 ctl 0xE1863238 bmdma 0x0 irq 19
> >ata2: SATA max UDMA/133 cmd 0xE1863280 ctl 0xE18632B8 bmdma 0x0 irq 19
> >ata1: no device found (phy stat 00000000)
> >ata1: thread exiting
> >scsi0 : sata_promise
> >ata2: no device found (phy stat 00000000)
> >ata2: thread exiting
> >scsi1 : sata_promise
> >
> >
> >So it can see the SATA ports.
> >
> >How do I get the kernel to see the ATA port on the card?
> 
> 
> The driver does not support the PATA ports.

Do you think it is reasonable to include support for PATA ports in
your code?
