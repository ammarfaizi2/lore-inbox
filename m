Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265716AbSKFPUR>; Wed, 6 Nov 2002 10:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265719AbSKFPUR>; Wed, 6 Nov 2002 10:20:17 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15597 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265716AbSKFPUC>; Wed, 6 Nov 2002 10:20:02 -0500
Date: Wed, 6 Nov 2002 10:27:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Khalid Aziz <khalid@fc.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] ide-scsi driver starts DMA too soon
In-Reply-To: <1036199633.14825.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0211061026500.27268-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-01 at 23:39, Khalid Aziz wrote:
> > ide-scsi driver starts DMA as soon as it writes the ATAPI PACKET command
> > in command register and before sending the ATAPI command. This will
> > cause problems on many drives. Right way to do it is to start DMA after
> > sending the ATAPI command. I am attaching a patch that fixes this. This
> > patch will allow many more CD-RW drives to work reliably in DMA mode
> > than do today.
> >
> > Marcelo, please apply.
>
> Marcelo this is in 2.5, and 2.4-ac. Khalid is certainly correct although
> making such a change in -rc rather than a pre does mean it wants extra
> thought

I prefer being safe and saving this one for 2.4.21-pre.

Thanks Khalid!

