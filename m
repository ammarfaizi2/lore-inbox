Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130903AbRCFDdv>; Mon, 5 Mar 2001 22:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130906AbRCFDdl>; Mon, 5 Mar 2001 22:33:41 -0500
Received: from nic-31-c31-100.mn.mediaone.net ([24.31.31.100]:2176 "EHLO
	nic-31-c31-100.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S130903AbRCFDdi>; Mon, 5 Mar 2001 22:33:38 -0500
Date: Mon, 5 Mar 2001 21:33:23 -0600 (CST)
From: "Scott M. Hoffman" <scott1021@mediaone.net>
X-X-Sender: <scott@nic-31-c31-100.mn.mediaone.net>
Reply-To: <scott1021@mediaone.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2-ac12
In-Reply-To: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>
Message-ID: <Pine.LNX.4.32.0103052121180.1029-100000@nic-31-c31-100.mn.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Richard B. Johnson wrote:
>
> Attempts to run linux-2.4.3-pre2 on chaos.analogic.com results
> in **MASSIVE** file-system destruction. I have (had) all SCSI
> disks, using the BusLogic controller.
>
> There is something **MAJOR** going on BAD, BAD, BAD, even disks
> that were not mounted got trashed.
<snip>
>
> I   -- S T R O N G L Y -- suggest that nobody use this kernel with
> a BusLogic SCSI controller until this problem is fixed.
>
> This is being sent from another machine, not on the list (actually
> from home where I am trying to see what happened -- I brought all
> 4 of my disks home). It looks like some kind of a loop. I have
> a pattern written throughout one of the disks.
>
> Cheers,
>
> Dick Johnson

 It may not be related, but out of five boot attempts, only one got past
the IDE driver stage(ie, below from 2.4.2 :
  VP_IDE: IDE controller on PCI bus 00 dev 39
  VP_IDE: chipset revision 16
  VP_IDE: not 100% native mode: will probe irqs later
  ide: Assuming 33MHz system bus speed for PIO modes; override with
  idebus=xx
  VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
      ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA)
  I've had 2.4.2 running great for the past 10 days. Need any more info?

Scott Hoffman
scott1021@mediaone.net





