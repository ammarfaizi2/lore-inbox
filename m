Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284366AbRLHTPt>; Sat, 8 Dec 2001 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284361AbRLHTPf>; Sat, 8 Dec 2001 14:15:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27403 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284368AbRLHTPY>;
	Sat, 8 Dec 2001 14:15:24 -0500
Date: Sat, 8 Dec 2001 20:15:15 +0100
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre7 ide-cd module
Message-ID: <20011208191515.GX11567@suse.de>
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de> <3C126634.F3BBC941@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C126634.F3BBC941@delusion.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08 2001, Udo A. Steinberg wrote:
> Jens Axboe wrote:
> > 
> > Upon first load, could you cat /proc/sys/dev/cdrom/info? It would appear
> > that the drive is sending zeroed data but not reporting a failure.
> > 
> > Is this a new problem?
> 
> Same problem here (2.5.1-pre), but the code is monolithic and not a module.
> 
> hde: ATAPI CD-ROM drive, 0kB Cache, DMA
>                          ^^^^^^^^^
> It used to work correctly before, which rules out a bad drive. Do you want
> me to check which kernel broke it first?

Yes please -- try 2.5.1-pre1 and 2.5.1-pre2, it probably broke there.

-- 
Jens Axboe

