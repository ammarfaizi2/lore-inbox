Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUINLMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUINLMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUINLMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:12:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47792 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269301AbUINLLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:11:07 -0400
Date: Tue, 14 Sep 2004 13:09:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914110932.GP2336@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095156346.16572.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Alan Cox wrote:
> On Maw, 2004-09-14 at 07:06, Jens Axboe wrote:
> > Alan, I bet there are a lot of these. Maybe we should consider letting
> > the user manually flag support for FLUSH_CACHE, at least it is in their
> > hands then.
> 
> You are assuming the drive supports "FLUSH_CACHE" just because it
> doesn't error it. Thats a good way to have accidents. 

I've yet to see one that lies about it, if timing is to be believed.
That would be close to criminal behaviour from the vendor, imho.

> The patch I posted originally did turn wcache off for barrier if no
> flush cache support was present but had a small bug so that bit got
> dropped.

That would be fine, though.

-- 
Jens Axboe

