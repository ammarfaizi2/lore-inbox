Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUG1Gvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUG1Gvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUG1Gvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:51:45 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:24150 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266351AbUG1Gvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:51:42 -0400
Message-ID: <c93051e8040727235123a6ed67@mail.gmail.com>
Date: Wed, 28 Jul 2004 14:51:42 +0800
From: Edward Angelo Dayao <edward.dayao@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040728053107.GB11690@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1090989052.3098.6.camel@camp4.serpentine.com> <20040728053107.GB11690@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yeah i get this kind of error in my logs as well from my liteon
dvd-rom at home. thats like 6 months old and happened on fc2 when i
had that installed on it. haven't noticed anything on mandrake 10 (the
current distro i use at home) with 2.6.7.

i got the same error on my old notebook, a compaq presario... that was
prior to the drive being sent to that big junk yard in the sky.  i
forget what model that was.  but i was running then...  rh9.

hope this bit helps guys resolve this. 

-cocoy

On Wed, 28 Jul 2004 07:31:08 +0200, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 27 2004, Bryan O'Sullivan wrote:
> > Hi, Jens -
> >
> > I'm having trouble reading a DVD or CD image from an ATAPI drive that
> > identifies itself as a 'LITEON DVD-ROM LTD163D'.  This is with vanilla
> > 2.6.7 on a system running Fedora Core 2.
> >
> > Regardless of what I do, I get the same errors:
> >
> >         Jul 27 21:18:30 camp4 kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> >         Jul 27 21:18:30 camp4 kernel: hdc: command error: error=0x54
> >         Jul 27 21:18:30 camp4 kernel: end_request: I/O error, dev hdc, sector 837264
> >         Jul 27 21:18:30 camp4 kernel: Buffer I/O error on device hdc, logical block 104658
> >
> > I have ide-cd compiled as a module.  This occurs whether or not ide-cd
> > is loaded (I don't have ide-scsi enabled), and whether or not I have DMA
> > turned on.
> >
> > I don't believe there is anything wrong with the drive, as it used to
> > work OK on 2.4, 2.5, and early 2.6 kernels, and I believe the media to
> > be fine, as the disk in question plays back on a Mac and a DVD player.
> >
> > Googling for "error=0x54", I see a lot of reports of this kind of
> > problem, but never with any resolutions, so I'm stumped.  Is there any
> > information I can give you that would help?
> 
> When does this happen - during kernel load, or during run of init
> scripts?
> 
> --
> Jens Axboe
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--
