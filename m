Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291333AbSBVCXS>; Thu, 21 Feb 2002 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291485AbSBVCXI>; Thu, 21 Feb 2002 21:23:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291333AbSBVCW6>; Thu, 21 Feb 2002 21:22:58 -0500
Subject: Re: HPT366: DMA errors?
To: sartre@linuxbr.com (Cesar Suga)
Date: Fri, 22 Feb 2002 02:36:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.40.0202212304240.438-100000@sartre.linuxbr.com> from "Cesar Suga" at Feb 21, 2002 11:14:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16e5Zw-0000al-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> through these messages when using the *original* ATA cable (never touched
> before) or a replacement one:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

CRC error -> cable/wiring problem. If you are using UDMA66/100 you must
have an 80pin cable. If you are using UDMA33 and can't pin it down then
an 80pin cable doesnt do any harm

Alan
