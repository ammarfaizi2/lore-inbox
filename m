Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbRCFVpI>; Tue, 6 Mar 2001 16:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRCFVo6>; Tue, 6 Mar 2001 16:44:58 -0500
Received: from nic-31-c31-100.mn.mediaone.net ([24.31.31.100]:4224 "EHLO
	nic-31-c31-100.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S129541AbRCFVou>; Tue, 6 Mar 2001 16:44:50 -0500
Date: Tue, 6 Mar 2001 15:44:27 -0600 (CST)
From: "Scott M. Hoffman" <scott1021@mediaone.net>
X-X-Sender: <scott@nic-31-c31-100.mn.mediaone.net>
Reply-To: <scott1021@mediaone.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2-ac12
In-Reply-To: <200103060421.UAA00897@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.32.0103061527450.1335-100000@nic-31-c31-100.mn.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.32.0103052121180.1029-100000@nic-31-c31-100.mn.mediaone.net>,
> Scott M. Hoffman <scott1021@mediaone.net> wrote:
> >
> > It may not be related, but out of five boot attempts, only one got past
> >the IDE driver stage(ie, below from 2.4.2 :
> >  VP_IDE: IDE controller on PCI bus 00 dev 39
> >  VP_IDE: chipset revision 16
> >  VP_IDE: not 100% native mode: will probe irqs later
> >  ide: Assuming 33MHz system bus speed for PIO modes; override with
> >  idebus=xx
> >  VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
> >      ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
> >      ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA)
> >
> >  I've had 2.4.2 running great for the past 10 days. Need any more info?
>
> I'd love to hear anything you can come up with. What's the next step in
> your boot process, ie what's the part that normally shows up but doesn't
> with 2.4.2-ac12? Is this using IDE-SCSI, for example?
>
> One thing that both 2.4.3-pre3 and -ac12 do is to not have allocate a
> result buffer for TEST_UNIT_READY. I don't see why that should matter,
> but can you try un-doing the patch to "scsi_error.c" and see if that
> makes a difference. I'm worried about this report, and the buslogic
> corruption thing..
>
> Justin: there's another "2.4.3-pre2 corrupts all disks on a buslogic
> controller" report. The interesting part is that 2.4.3-pre2 doesn't
> actually contain any buslogic changes. The only generic-scsi changes
> were yours. Ideas?
>
> 		Linus
>

  Just trying 2.4.3-pre2 now. It appears to be working fine. I used the
same config from my ac11-12 attempts. My systems problem with ac11-12 must
not be something common between them.  Hope this helps.

Scott



