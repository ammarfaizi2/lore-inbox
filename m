Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRBVVyH>; Thu, 22 Feb 2001 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRBVVx6>; Thu, 22 Feb 2001 16:53:58 -0500
Received: from altern.org ([212.73.209.210]:20746 "HELO altern.org")
	by vger.kernel.org with SMTP id <S129394AbRBVVxv>;
	Thu, 22 Feb 2001 16:53:51 -0500
Date: Thu, 22 Feb 2001 22:48:56 +0100 (CET)
From: <alcove@altern.org>
Subject: Problem with ATA/UDMA
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <20010222215353Z129394-30605+137@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys

I have a HPT370 controler card, with a 60 gigs Maxtor IDE drive
Card BIOS detects it to be UDMA5.

It happens that the system hangs (seems it is especially when system has been up for more than 24 hours)(this is home box)

Here is output it gives me:

***************
hdf: timeout waiting for DMA
ide_dmaproc : chipset supported ide_dma_timeout func only : 14
hdf : irq timeout : status=0x48 {DriveReady DataRequest }
hdf : DMA disabled
ide2 : reset : master : error (0x0a?)
***************

I would like to know what the probem is.
I looked on the net and found that some people had exactly the same output in very earlier kernel versions (2.0)
Anyway, does anyone know about a bug on this? Is there any patch, or any current development about this?

Or does it simply mean my HD is diing? :-(

Sorry if question is obvious

Vincent
