Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290718AbSBSN6U>; Tue, 19 Feb 2002 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSBSN6K>; Tue, 19 Feb 2002 08:58:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18958 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289880AbSBSN56>; Tue, 19 Feb 2002 08:57:58 -0500
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
To: kristian.peters@korseby.net (Kristian)
Date: Tue, 19 Feb 2002 14:12:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <20020219135758.67f7f4c2.kristian.peters@korseby.net> from "Kristian" at Feb 19, 2002 01:57:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dB0A-0000aZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No hdparm settings. 40pin cable and this drive:
> 
> $ dmesg|grep hda
>     ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:DMA
> hda: WDC AC24300L, ATA DISK drive
> hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=557/240/63, UDMA(33)
> 
> 00:14.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

PIIX and the WDC drive is supposed to be past the range that had the
nasty UDMA DMA bugs.

> Before you ask: I'll test memory later just to be sure.	
 
Ok

