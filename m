Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132107AbRBFAYv>; Mon, 5 Feb 2001 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136063AbRBFAYm>; Mon, 5 Feb 2001 19:24:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:56583
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136091AbRBFAYJ>; Mon, 5 Feb 2001 19:24:09 -0500
Date: Mon, 5 Feb 2001 16:23:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rogerio Brito <rbrito@iname.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't
 work)
In-Reply-To: <20010205220109.A9945@iname.com>
Message-ID: <Pine.LNX.4.10.10102051622440.30462-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Rogerio Brito wrote:

> On Feb 05 2001, Jens Axboe wrote:
> > 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);
> 
> 	I'd like to thank everybody that replied either on the list
> 	and privately. I didn't know that I could just use the /proc
> 	entries to change the IDE driver speed with a simple:
> 
> 	echo current_speed:4 > /proc/ide/hdc/settings

You can not it has nothing to do with the speed of the device but the
transfer rate between the host and the device.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
