Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSHPL3L>; Fri, 16 Aug 2002 07:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSHPL3L>; Fri, 16 Aug 2002 07:29:11 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33552
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318314AbSHPL3K>; Fri, 16 Aug 2002 07:29:10 -0400
Date: Fri, 16 Aug 2002 04:10:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <Pine.NEB.4.44.0208161309240.6334-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.10.10208160408570.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan change all "IN_BYTE" in hd.c to "inb"


On Fri, 16 Aug 2002, Adrian Bunk wrote:

> Hi Alan,
> 
> the following compile error is still present when trying compiling a
> kernel with CONFIG_BLK_DEV_HD enabled:
> 
> <--  snip  -->
> 
> ...
>         /home/bunk/linux/kernel-2.4/linux-2.4.19-full/arch/i386/lib/lib.a
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/lib/lib.a
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/ide/idedriver.o: In function `dump_status':
> drivers/ide/idedriver.o(.text+0x68): undefined reference to `IN_BYTE'
> drivers/ide/idedriver.o: In function `reset_controller':
> drivers/ide/idedriver.o(.text+0x55e): undefined reference to `IN_BYTE'
> make: *** [vmlinux] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
> -- 
> 
> You only think this is a free country. Like the US the UK spends a lot of
> time explaining its a free country because its a police state.
> 								Alan Cox
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

