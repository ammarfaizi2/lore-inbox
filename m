Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUELR1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUELR1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUELR1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 13:27:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6557 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265132AbUELR0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 13:26:37 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: garski@poczta.onet.pl
Subject: Re: SiI3112 Serial ATA - no response on boot
Date: Wed, 12 May 2004 19:26:43 +0200
User-Agent: KMail/1.5.3
References: <200405112052.44979.garski@poczta.onet.pl> <40A12409.40808@dotnetitalia.it> <200405121851.42401.garski@poczta.onet.pl>
In-Reply-To: <200405121851.42401.garski@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121926.43050.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 of May 2004 18:51, Marcin Garski wrote:
> [Please CC me on replies, I am not subscribed to the list, thanks]
>
> Marco Adurno wrote:
> > I've got the same problem some time ago.
> > You have just to appen the string
> > hdg=none
> > in your boot loader config file
>
> Thanks, that's working.
> But isn't that a workaround for problem with probe (on NON SATA HDD
> probe don't generate such errors) that should be fixed somehow?

Yes, feel free to fix it. ;-)

> > Marcin Garski wrote:
> > > Hi,
> > >
> > > I have a Abit NF7-S V2.0 mainboard (nForce2 chipset + SiI3112
> > > SATA), with Seagate S-ATA connected to Sil3112.
> > >
> > > During boot i get following messages:
> > > SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
> > > SiI3112 Serial ATA: chipset revision 2
> > > SiI3112 Serial ATA: 100% native mode on irq 11
> > >     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
> > >     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> > > hde: ST380013AS, ATA DISK drive
> > > ide2 at 0xe083c080-0xe083c087,0xe083c08a on irq 11
> > > hdg: no response (status = 0xfe)
> > > hdg: no response (status = 0xfe), resetting drive
> > > hdg: no response (status = 0xfe)
> > >
> > > Each "no response" message delays booting about 20 seconds.
> > > I don't have any device connected to hdg.
> > > I was wondering how to speed up booting, because this "hdg: no
> > > response (status = 0xfe), resetting drive" info is little
> > > irritating? I'm running on 2.6.6 kernel (on 2.6.4 this "no
> > > response" messages also appear).

