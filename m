Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUIOJFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUIOJFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUIOJFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:05:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32736 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264256AbUIOJBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:01:12 -0400
Date: Wed, 15 Sep 2004 10:59:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Lars =?iso-8859-1?Q?T=E4uber?= <taeuber@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: cdrom recognition on kernel 2.6.8.1
Message-ID: <20040915085939.GU2304@suse.de>
References: <20040915093635.1a8f08ff.taeuber@bbaw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040915093635.1a8f08ff.taeuber@bbaw.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, Lars Täuber wrote:
> Hallo everybody,
> 
> I'm not subscribed to this list! But I read the archive from time to time.
> 
> In my linux box is a teac IDE CD-Rom drive. This is only recognised
> when no audio cd is in the drive while booting.  Is this a drive
> failure, or a kernel failure?
> 
> I didn't find any other on the net with the same problem. So hopefully
> someone of you can explain?
> 
> ............
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
> NFORCE3-150: chipset revision 165
> NFORCE3-150: not 100% native mode: will probe irqs later
> NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> libata version 1.02 loaded.
> sata_sil version 0.54
> ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 11 (level, low) -> IRQ 11
> ............

Did 2.6.7 work? The ide-probe isn't finding your drive, that's very odd.
I think this is an issue with your hardware, not Linux. Perhaps you can
use the drive if you add hdc=cdrom to your boot line.

-- 
Jens Axboe

