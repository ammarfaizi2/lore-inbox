Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSHQSaH>; Sat, 17 Aug 2002 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSHQSaH>; Sat, 17 Aug 2002 14:30:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40977
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318143AbSHQSaE>; Sat, 17 Aug 2002 14:30:04 -0400
Date: Sat, 17 Aug 2002 11:24:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <Pine.NEB.4.44.0208161332150.6334-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.10.10208171124070.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


EEK,

I will fix it!

On Fri, 16 Aug 2002, Adrian Bunk wrote:

> On Thu, 15 Aug 2002, Alan Cox wrote:
> 
> >...
> > Linux 2.4.20-pre2-ac3
> > o	IDE updates					(Andre Hedrick)
> >...
> 
> drivers/ide/ide.c no longer exports do_ide_request and
> ide_add_generic_settings but they are still needed by
> drivers/ide/ide-probe-mod.c:
> 
> <--  snip  -->
> 
> ...
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.20-pre2-ac3/kernel/drivers/ide/ide-probe-mod.o
> depmod:         do_ide_request
> depmod:         ide_add_generic_settings
> ...
> 
> <--  snip   -->
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
> 
> 

Andre Hedrick
LAD Storage Consulting Group

