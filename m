Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313969AbSDPXsN>; Tue, 16 Apr 2002 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313970AbSDPXsM>; Tue, 16 Apr 2002 19:48:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313969AbSDPXsL>; Tue, 16 Apr 2002 19:48:11 -0400
Subject: Re: IDE Problems
To: p.nikolic@btinternet.com (Peter Nikolic)
Date: Wed, 17 Apr 2002 00:56:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16xcG3-0002D4-00@rhenium.btinternet.com> from "Peter Nikolic" at Apr 17, 2002 12:20:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xco4-00019Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(33)
> hdb: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)

> end_request: I/O error, dev 03:03 (hda), sector 942192
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 

You have a bad block on /dev/hda3

> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 

In fact a couple.

Thats the Linux version of the good old "Abort, Retry, Ignore" in DOS when
the disk fails. 

Alan
