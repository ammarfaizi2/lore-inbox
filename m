Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSHCVy7>; Sat, 3 Aug 2002 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSHCVy7>; Sat, 3 Aug 2002 17:54:59 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:4881 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S317924AbSHCVy6>; Sat, 3 Aug 2002 17:54:58 -0400
Message-ID: <3D4C5209.67385E8C@netpathway.com>
Date: Sat, 03 Aug 2002 16:58:33 -0500
From: Gary White <gary@netpathway.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue
References: <20020803163708.GHUY23840.mta03-svc.ntlworld.com@[10.137.100.63]> <1028397650.1760.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.4 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan I have the same problem Just complied 2.4.10-ac1 and I it did
not help. I only have a problem if I compile in the ALI M15x3 chipset
support so I can use DMA. Without DMA the partition check zooms right
past the 2 Maxtor 120GB drives I am having a problem with.

Note: I do have an AWARD Bios and have tried the with and without
Auto-Geometry Resizing support compiled in the kernel.

Oly boots if I don't use DMA and generic controller support.

> 
> On Sat, 2002-08-03 at 17:37, alien.ant@ntlworld.com wrote:
> > Hi,
> >
> > I attempted to upgrade from 2.4.18 to 2.4.19 today but one of machines repeatedly hangs at the "Partition check" on the IDE drives.
> >
> > The machine is a Compaq Proliant 800 Pentium III SMP box with a Highpoint 370 IDE controller. I attempted several reboots with the check continually failing. Rebooting back to 2.4.18 removed the problem.
> >
> > Searching the archive I note several other people have had this problem with 2.4.19-pre kernels but, as yet, there seems to be no resolution?
> >
> Can you try 2.4.19-ac1 once I upload it. That has slightly further
> updated IDE code and it would useful to know if the same problem occurs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Gary White                                  admin@netpathway.com
Network Administrator                           Internet Pathway
P. O. Box 777, 105 D East Church Street        Quitman, MS 39355
Voice: 601-776-3355                            Fax: 601-776-2314

________________________________________________________
This email has been scanned by Internet Pathway's Email
Gateway scanning system for potentially harmful content,
such as viruses or spam. Nothing out of the ordinary was
detected in this email. For more information, call
601-776-3355 or email emailscanner@netpathway.com
________________________________________________________
