Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUH2OHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUH2OHi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUH2OHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:07:37 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54912 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267839AbUH2OHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:07:31 -0400
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Sebor <petr@scssoft.com>
Cc: Petter =?ISO-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412FC7A7.4030100@scssoft.com>
References: <412F5D50.7000807@findus.dhs.org> <412FC7A7.4030100@scssoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093784706.27899.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 14:05:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-28 at 00:45, Petr Sebor wrote:
> just a 'me too' e-mail... I have Master2-FAR mobo, VIA/KT800 chipset.
> IDE disk runs like a charm but SATA disks consume big amount of cpu
> time (which is spent in iowait). The system behaves exactly as with
> old IDE disk and DMA disabled... everything is slow when data is 
> transferred to/from disk.

Make sure you enable the SCSI later, SATA drivers and VIA SATA driver
otherwise you may end up using PIO with the PCI generic IDE driver.

