Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRAaNZM>; Wed, 31 Jan 2001 08:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRAaNZC>; Wed, 31 Jan 2001 08:25:02 -0500
Received: from nat-20.kulnet.kuleuven.ac.be ([134.58.0.20]:13754 "EHLO
	scoezie.kotnet.org") by vger.kernel.org with ESMTP
	id <S130921AbRAaNYu>; Wed, 31 Jan 2001 08:24:50 -0500
Date: Wed, 31 Jan 2001 14:27:15 +0100 (CET)
From: Davy Preuveneers <davy.preuveneers@student.kuleuven.ac.be>
To: linux-kernel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel zip-disk can't use EPP 32 bit with 2.4.x kernels
In-Reply-To: <20010130131219.A13071@bliss.zebra.net>
Message-ID: <Pine.LNX.4.21.0101311426030.3169-100000@scoezie.kotnet.org>
Organization: "kotnet" <www.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, 30 Jan 2001, Forever shall I be. wrote:

> On Tue, Jan 30, 2001 at 07:17:28PM +0100, Davy Preuveneers wrote:
> > Since I'm running the 2.4.x kernels, I'm having a little problem with my
> > parallel zip-disk. The ppa module can't use the EPP 32 protocol and uses
> > the PS/2 protocol instead (which is much slower), as shown by the boot
> > message of kernel 2.4.1:
> > 
> [snip]
> > 
> > Kernels 2.2.x use the EPP 32 bit protocol while the 2.4.x versions don't,
> > although I have used the same options when compiling the new 2.4.1 kernel.
> > When I change the parallel port configuration in the BIOS from ECP/EPP to
> > EPP only (version 1.9), the 2.4.x kernels use the EPP 32 bit protocol as 
> > well, but then I can't use ECP with dma anymore.
> > 
> > Does anyone know what the problem is?
> 
> Are you sure you've given parport_pc the correct IRQ/DMA? It doesn't
> seem to be able to detect them very well over here, so I need a line
> such as:
> 	options parport_pc io=0x378 irq=7 dma=3
> 
> but YMMV :)

Yes, I tried that already, but no effect

> 
> > 
> > Davy
> 
> -- 
> Zinx Verituse                           (See headers for gpg key info)
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
