Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbRE3FOh>; Wed, 30 May 2001 01:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRE3FO1>; Wed, 30 May 2001 01:14:27 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:22020 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262600AbRE3FOO>; Wed, 30 May 2001 01:14:14 -0400
Date: Tue, 29 May 2001 22:14:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vasile Gaburici <gaburici@cs.umd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: pdc20268 error?
In-Reply-To: <Pine.SOL.4.21.0105292223420.6802-300000@jrmint.cs.umd.edu>
Message-ID: <Pine.LNX.4.10.10105292210430.3596-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not an error.
The new PDC20268 has all the register data hidden form the user.
Another anti-user-friendly reaction by Promise Technology.
However, the up side is that they were smart enough to make the taskfile
registers for the setfeatures command auto set the host values.

Basically there are no data points that can be read from the new TX2 that
have any real trustable world meaning.

Cheers,

On Tue, 29 May 2001, Vasile Gaburici wrote:

> Date: Tue, 29 May 2001 22:41:38 -0400 (EDT)
> From: Vasile Gaburici <gaburici@cs.umd.edu>
> To: Andre Hedrick <andre@linux-ide.org>
> Subject: pdc20268 error?
> 
> 
> 	Hi,
> 
> 	I've got a Promise Ultra100 TX2 board to work with 2.2.19 plus
> your ide.2.2.19.05042001 patch. I've only attached one UDMA33 capable
> CD-ROM drive to the primary a channel of the card to see how things go. I
> can mount access it okay (via hde).
> 
> 	The fact that troubles me is that 'cat /proc/ide/pdc202xx' seems
> to indicate that the board is in error and cannot determine PIO and DMA
> modes for the devices (see attachments). Is this normal for my config or
> is it a bug?
> 
> 	Also, I'd like to know if the shortcuts in the driver for 20268
> (various gotos that skip code) are mandated by some improved hardware or
> just lack of info for the 20268...
> 
> 
> 	Thanks,
> 	Vasile
> 
> 	P.S.: Is there a list for ide-only discussion? 200/day on lklm is
> too much for me...
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

