Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbTCWLJr>; Sun, 23 Mar 2003 06:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263024AbTCWLJr>; Sun, 23 Mar 2003 06:09:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263021AbTCWLJp>;
	Sun, 23 Mar 2003 06:09:45 -0500
Date: Sun, 23 Mar 2003 12:20:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030323112053.GL837@suse.de>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk> <20030323092719.GB3818@merlin.emma.line.org> <20030323111917.GK837@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323111917.GK837@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23 2003, Jens Axboe wrote:
> On Sun, Mar 23 2003, Matthias Andree wrote:
> > On Sat, 22 Mar 2003, Alan Cox wrote:
> > 
> > > -	Add ATAPI virtual DMA
> > > -	Add DMA active irq poll trick
> >  ...
> > > -	ADMA full support
> > > -	Mark Lord/Andre ideas on LBA28/LBA48
> > 
> > Will anything of this enable SG_IO via IDE-SCSI to do DMA with 2448 or
> > 2352 bytes per block, or have other means to reduce the system load
> > when writing a CD?
> 
> SG_IO can already do that, it's been able to do that for a long time in
> 2.5.

Correction, use ide-cd in 2.5 and it will do that. Don't use ide-scsi
for anything but tapes in 2.5

-- 
Jens Axboe

