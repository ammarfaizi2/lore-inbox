Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTGKOlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTGKOlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:41:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:901 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262714AbTGKOlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:41:14 -0400
Date: Fri, 11 Jul 2003 16:55:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003, Alan Cox wrote:

> On Gwe, 2003-07-11 at 15:02, Dave Jones wrote:
> > - (Possibly linked to above bug) VIA APIC routing is currently broken.
> >   boot with 'noapic'.
>
> Does 2.5 not have the INTD routing fix yet ?

In 2.5.75.

> > - The hptraid/promise RAID drivers are currently non functional, and
> >   will probably be converted to use device-mapper.

Please put software RAID here to avoid confusion.

> > IDE.
> > ~~~~
> > - Known problems with the current IDE code.
> >   o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
> FIXED
> >   o  PCMCIA IDE hangs on eject
> Should be fixed in 2.5, fixed(ish) in 2.4
> >   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> >      either use 2.4 or fix it 8)
> > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> >   are no longer supported. The only way forward is to remove the translator
> >   from the drive, and start over.
>
> Or to use device mapper to remap the disk.

"hdx=remap" and "hdx=remap63" boot options can be used.
Or can I remove them?

--
Bartlomiej

