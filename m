Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTAJSRU>; Fri, 10 Jan 2003 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTAJSRU>; Fri, 10 Jan 2003 13:17:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10917 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265238AbTAJSRT>;
	Fri, 10 Jan 2003 13:17:19 -0500
Date: Fri, 10 Jan 2003 19:25:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
Message-ID: <20030110182549.GN843@suse.de>
References: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org> <1042207998.28469.98.camel@irongate.swansea.linux.org.uk> <20030110164834.GM843@suse.de> <1042222339.32175.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042222339.32175.3.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10 2003, Alan Cox wrote:
> On Fri, 2003-01-10 at 16:48, Jens Axboe wrote:
> > In the barrier patches, I just used drive->quiet to supress ide_error()
> > complaining too much (on cache flushes, too). Whether that's per-drive
> > of per-hwif entity, dunno...
> 
> Commands are queued per hwif so it doesn't actually matter I suspect.

True

> BTW do you plan to fix up the oopses in the tcq code or should I just mark
> it disabled for anyone who has the time to finish the job ? There are a 
> whole pile of drivers that fail with tcq - mostly because they have custom
> dma end functions

Yes I will get around to it, probably next week.

-- 
Jens Axboe

