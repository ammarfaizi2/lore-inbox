Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283105AbRK2JEr>; Thu, 29 Nov 2001 04:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283103AbRK2JEi>; Thu, 29 Nov 2001 04:04:38 -0500
Received: from frank.gwc.org.uk ([212.240.16.7]:16904 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S283105AbRK2JE3>;
	Thu, 29 Nov 2001 04:04:29 -0500
Date: Thu, 29 Nov 2001 09:04:26 +0000 (GMT)
From: Alistair Riddell <ali@gwc.org.uk>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] block-highmem-all-18b
In-Reply-To: <20011122172700.I19902@suse.de>
Message-ID: <Pine.LNX.4.21.0111290856290.10924-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erk... I applied this patch to 2.2.16pre1 on a 2GB SMP machine with an
onboard aic7899 scsi controller. This morning I came in to find the
machine had panicked with "Ththththaats all folks.  Too dangerous to
continue." 

There was nothing else in syslog either remotely or on disk, and nothing
else on the console apart from the panic.

Any ideas what might cause this?

Let me know if I can provide any further information.


On Thu, 22 Nov 2001, Jens Axboe wrote:

> A minor update version, nothing major. Changes:
> 
> - Megaraid highmem I/O enabled again, since 2.4.14 this should be safe.
>   Verified by Arjan. (me)
> - Change can_dma_32 to highmem_io to make the meaning more clear (me).
> - Drop discontig pfn change for now (me)
> 
> Find it here:
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.15-pre9/block-highmem-all-18b.bz2

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 446 6070    Fax: +44 131 452 8594
Microsoft - because god hates us

