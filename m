Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIORLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIORLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUIORJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:09:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:45271 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266821AbUIOREs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:04:48 -0400
X-Authenticated: #4664463
Date: Wed, 15 Sep 2004 19:15:32 +0200
From: Lars =?ISO-8859-15?Q?T=E4uber?= <lars.taeuber@gmx.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: cdrom recognition on kernel 2.6.8.1
Message-Id: <20040915191532.246dc6ca.lars.taeuber@gmx.net>
In-Reply-To: <20040915085939.GU2304@suse.de>
References: <20040915093635.1a8f08ff.taeuber@bbaw.de>
	<20040915085939.GU2304@suse.de>
Reply-To: taeuber@informatik.hu-berlin.de
Organization: Familie =?ISO-8859-15?Q?T=E4uber?=
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens,

the problem accours also under 2.6.7.
But the hdc=cdrom options solves this problem (under 2.6.8.1):

..............
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdc: ATAPI cdrom (?)
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
..............




As written bevore the drive is not recognised only with an audio cd in it.

Thanks
Lars

On Wed, 15 Sep 2004 10:59:39 +0200
Jens Axboe <axboe@suse.de> wrote:

> 
> Did 2.6.7 work? The ide-probe isn't finding your drive, that's very odd.
> I think this is an issue with your hardware, not Linux. Perhaps you can
> use the drive if you add hdc=cdrom to your boot line.
> 
> -- 
> Jens Axboe
> 


-- 
Schöne Grüße
Lars Täuber

