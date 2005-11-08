Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbVKHOVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbVKHOVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbVKHOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:21:39 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:32982 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S965219AbVKHOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:21:38 -0500
Date: Tue, 8 Nov 2005 15:21:40 +0100
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1 libata pata_via
Message-ID: <20051108142140.GA2790@favonius>
Reply-To: sander@humilis.net
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net> <20051108121318.GB23549@favonius> <1131455213.25192.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131455213.25192.26.camel@localhost.localdomain>
X-Uptime: 15:02:54 up  1:02, 10 users,  load average: 3.88, 1.95, 1.19
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Maw, 2005-11-08 at 13:13 +0100, Sander wrote:
> > The two pata disks are master and slave. I might try them on separate
> > channels later (especially if you want me to :-)
> 
> Would be interesting. It shouldn't change the behaviour but more info
> is good.

I'll do.

> > [42949377.130000]  sdf:<3>ata5: command error, drv_stat 0x51 host_stat 0x64
> > [42949377.210000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [42949377.210000] ata5: status=0x51 { DriveReady SeekComplete Error }
> 
> Thats the important bit. It looks as if I got the timing clock loading
> wrong for this chip. (My EPIA works nicely but all the info I need is in
> your report).

Good to know.

I see your new patch against 2.6.14-mm1 has updates for pata_via.c. It
does not address this issue I presume?

-- 
Humilis IT Services and Solutions
http://www.humilis.net
