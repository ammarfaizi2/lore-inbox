Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSHZSGr>; Mon, 26 Aug 2002 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSHZSGq>; Mon, 26 Aug 2002 14:06:46 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57355
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318176AbSHZSGp>; Mon, 26 Aug 2002 14:06:45 -0400
Date: Mon, 26 Aug 2002 11:08:51 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ATA err with 2.4.20-ac1
In-Reply-To: <20020826141404.3a73e8ed.Gregor.Fajdiga@telemach.net>
Message-ID: <Pine.LNX.4.10.10208261107240.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Grega Fajdiga wrote:

> Good day,
>  
> > If people report IDE stuff I need to know the context, dmesg, controller
> > and drives. 
> 
> /dev/hda/: Maxtor 91021U2
> dev/hdb: ST31722A
> 
> hda: Maxtor 91021U2, ATA DISK drive
> hdb: ST31722A, ATA DISK drive
> hdc: FX240S, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=1245/255/63, UDMA(33)
> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }

Place bets on geometry call or recal!
No sweat guys.

> hdb: 3329424 sectors (1705 MB) w/128KiB Cache, CHS=825/64/63, UDMA(33)
> hdc: ATAPI 24X CD-ROM drive, 256kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
>  hdb: hdb1

It is an old drive and did not like the command.

Andre Hedrick
LAD Storage Consulting Group

