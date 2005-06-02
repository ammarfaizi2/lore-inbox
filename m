Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFBJeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFBJeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVFBJd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:33:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261325AbVFBJd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:33:57 -0400
Date: Thu, 2 Jun 2005 03:32:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?TU9LUkVKX18=?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-git6 mis-counted ide interfaces
Message-Id: <20050602033253.77cd66d9.akpm@osdl.org>
In-Reply-To: <429ECE20.1030403@ribosome.natur.cuni.cz>
References: <429ECE20.1030403@ribosome.natur.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>
>   I get the following when I boot my PIIX computer (Asus P4C800E-Deluxe):
> 
> 
>  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>  ide: Assuming 66MHz system bus speed for PIO modes
>  ICH5: IDE controller at PCI slot 0000:00:1f.1
>  PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>  ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
>  ICH5: chipset revision 2
>  ICH5: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
>  Probing IDE interface ide0...
                         ^^^^ Here's ide0

>  hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  Probing IDE interface ide1...
>  ----------------------^^^^ ide0 I believe

Does the kernel boot and run OK, or does something actually go wrong?
