Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSKBV3r>; Sat, 2 Nov 2002 16:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKBV3q>; Sat, 2 Nov 2002 16:29:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42881 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261430AbSKBV3j>;
	Sat, 2 Nov 2002 16:29:39 -0500
Date: Sat, 2 Nov 2002 22:35:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021102213529.GB3612@suse.de>
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de> <20021102174727.GA294@dreamland.darkstar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102174727.GA294@dreamland.darkstar.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Kronos wrote:
> Il Sat, Nov 02, 2002 at 04:27:25PM +0100, Jens Axboe ha scritto: 
> > > I can't even mount a cd using my CDRW drive (CD-ROM drive is ok).
> > 
> > Does 2.5.42 work?
> 
> I can reproduce it using hdparm -i /dev/hdd:
> 
> hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdd: drive_cmd: error=0x04Aborted Command
> hdd: irq timeout: status=0xd0 { Busy }
> hdd: irq timeout: error=0xd0LastFailedSense 0x0d
> hdd: status timeout: status=0xd0 { Busy }
> hdd: status timeout: error=0xd0LastFailedSense 0x0d
> hdd: DMA disabled
> hdd: drive not ready for command
> hdd: ATAPI reset complete
> hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdd: packet command error: error=0x50
> end_request: I/O error, dev 16:40, sector 0
> end_request: I/O error, dev 16:40, sector 0
> hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
> hdd: request sense failure: error=0x50LastFailedSense 0x05

What is this, 2.5.42 or 2.5.45? Does 2.5.42 work or not? You haven't
answered my question at all.

-- 
Jens Axboe

