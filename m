Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTIMT5X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTIMT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:57:23 -0400
Received: from havoc.gtf.org ([63.247.75.124]:52628 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262176AbTIMT5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:57:21 -0400
Date: Sat, 13 Sep 2003 15:57:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913195719.GA17576@gtf.org>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org> <200309132124.05974.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309132124.05974.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 09:24:05PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 13 of September 2003 20:49, Jeff Garzik wrote:
> > For 2.6, libata (unfortunately) requires the SCSI layer for ATA
> > devices, and libata drives real hardware that noone else can drive.
> >
> > For 2.7, when all this code "moves up" -- basically adding a bunch of
> > helper functions to the block layer -- libata won't need to treat ATA
> > devices as SCSI devices.
> 
> s/ATA/SATA/
> 
> ATA and SATA will still need their own driver(s) aware of driver-model,
> sysfs, ATA quirks/tuning etc.

Agreed.  Though I think some of your work in sysfs area can be made
common.


> I am working on this part currently, so you can
> concentrate on new, sexy SATA, leaving all dirty, legacy ATA for me.

Sounds good to me ;-)  Though I'll definitely want to work together with
you on several issues in 2.7...


> For all other stuff described in your mail I can only say: HELL YEAH!.

;-)

	Jeff



