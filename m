Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUHVPMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUHVPMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHVPMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:12:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64899 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267407AbUHVPMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:12:12 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Davis <tadavis@lbl.gov>
Subject: Re: 2.6.8.1-mm3
Date: Sun, 22 Aug 2004 17:11:35 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <412821C4.7060402@lbl.gov>
In-Reply-To: <412821C4.7060402@lbl.gov>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408221711.35423.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 August 2004 06:32, Thomas Davis wrote:
> 4) why does this happen (hdd is reported to be PIO, but it's not..)
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH5: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio

these are "BIOS settings", IDE driver overrides them

