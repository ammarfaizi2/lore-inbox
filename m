Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132069AbRADUG7>; Thu, 4 Jan 2001 15:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRADUGi>; Thu, 4 Jan 2001 15:06:38 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:65293
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131315AbRADUG3>; Thu, 4 Jan 2001 15:06:29 -0500
Date: Thu, 4 Jan 2001 12:05:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Sven Koch <haegar@cut.de>
cc: Igmar Palsenberg <maillist@chello.nl>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.30.0101042051110.22989-100000@space.comunit.de>
Message-ID: <Pine.LNX.4.10.10101041205020.2092-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have a hard destroke clipping on the drive.
Go look at you logs.

On Thu, 4 Jan 2001, Sven Koch wrote:

> On Thu, 4 Jan 2001, Igmar Palsenberg wrote:
> 
> > kernel 2.2.18 hates my Maxtor drive :
> >
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hda: Maxtor 96147H6, 32253MB w/2048kB Cache, CHS=65531/16/63, (U)DMA
> >
> > Actual (correct) parameters : CHS=119112/16/63
> >
> > Looks like some short int (2 bytes) overflowing. I'll try the ide patches.
> 
> This type of harddisk works for me with the ide patches. I had to
> recompile fdisk as my old suse 6.4 version got the same 2byte-wraparound
> problem.
> 
> c'ya
> sven
> 
> -- 
> 
> The Internet treats censorship as a routing problem, and routes around it.
> (John Gilmore on http://www.cygnus.com/~gnu/)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
