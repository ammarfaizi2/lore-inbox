Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281156AbRK3W5i>; Fri, 30 Nov 2001 17:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281103AbRK3W52>; Fri, 30 Nov 2001 17:57:28 -0500
Received: from e204233.upc-e.chello.nl ([213.93.204.233]:13321 "EHLO
	mortal.servicez.org") by vger.kernel.org with ESMTP
	id <S281156AbRK3W5V>; Fri, 30 Nov 2001 17:57:21 -0500
Message-ID: <000901c179f2$54ca86d0$fa03a8c0@mortal>
From: "Patrick Dijkkamp" <list@mortal.servicez.org>
To: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0111301901320.17660-100000@freak.distro.conectiva>
Subject: Re: Linux 2.4.17-pre2
Date: Fri, 30 Nov 2001 23:57:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot again to change the SUBLEVEL and EXTRAVERSION.


Patrick Dijkkamp
list@mortal.servicez.org
Netherlands

> 
> 
> Ok, here it goes.
> 
> Lots of driver changes this time... 
> 
> Also, I want to know if people feel any difference on interactivity under
> heavy IO workloads.
> 
> pre2:
> 
> - Remove userland header from bonding driver (David S. Miller)
> - Create a SLAB for page tables on i386 (Christoph Hellwig)
> - Unregister devices at shaper unload time (David S. Miller)
> - Remove several unused variables from various
>   places in the kernel (David S. Miller)
> - Fix slab code to not blindly trust cc_data():
>   it may be not valid on some platforms (David S. Miller)
> - Fix RTC driver bug (David S. Miller)
> - SPARC 32/64 update (David S. Miller)
> - W9966 V4L driver update (Jakob Jemi)
> - ad1848 driver fixes (Alan Cox/Daniel T. Cobra)
> - PCMCIA update (David Hinds)
> - Fix PCMCIA problem with multiple PCI busses (Paul Mackerras)
> - Correctly free per-process signal struct (Dave McCracken)
> - IA64 PAL/signal headers cleanup (Nathan Myers)
> - ymfpci driver cleanup (Pete Zaitcev)
> - Change NLS "licenses" to be "GPL/BSD" instead 
>   only BSD. (Robert Love)
> - Fix serial module use count (Russell King)
> - Update sg to 3.1.22 (Douglas Gilbert)
> - ieee1394 update (Ben Collins)
> - ReiserFS fixes (Nikita Danilov)
> - Update ACPI documentantion (Patrick Mochel)
> - Smarter atime update (Andrew Morton)
> - Correctly mark ext2 sb as dirty and sync it (Andrew Morton) 
> - IrDA update (Jean Tourrilhes)
> - Count locked buffers at
>   balance_dirty_state(): Helps interactivity under
>   heavy IO workloads (Andrew Morton)
> - USB update (Greg KH)
> - ide-scsi locking fix (Christoph Hellwig)
> 


