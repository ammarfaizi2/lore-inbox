Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbSJOIjc>; Tue, 15 Oct 2002 04:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSJOIjc>; Tue, 15 Oct 2002 04:39:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263356AbSJOIjb>;
	Tue, 15 Oct 2002 04:39:31 -0400
Date: Tue, 15 Oct 2002 10:21:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-lvm@sistina.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021015082152.GA4827@suse.de>
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <1034614756.29775.5.camel@UberGeek.coremetrics.com> <20021014175608.GA14963@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014175608.GA14963@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14 2002, Joe Thornber wrote:
> 10.patch
>   [Device-mapper]
>   Add call to blk_queue_bounce() at the beginning of the request function.

What on earth for? I also see that you are setting BLK_BOUNCE_HIGH as
the bounce limit unconditionally for your queue. Puzzled.

When does dm even have to touch the data in the bio?

-- 
Jens Axboe

