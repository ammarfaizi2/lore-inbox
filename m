Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272488AbTGZOFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272489AbTGZOFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:05:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30849 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272488AbTGZOFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:05:19 -0400
Date: Sat, 26 Jul 2003 16:07:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, willy@w.ods.org,
       hch@lst.de, uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Make I/O schedulers optional (Was: Re: Kernel 2.6 size increase)
Message-ID: <20030726140745.GB518@suse.de>
References: <200307232046.46990.bernie@develer.com> <200307260155.15099.bernie@develer.com> <20030726011708.6aa29641.akpm@osdl.org> <200307261440.52002.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261440.52002.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26 2003, Bernardo Innocenti wrote:
> diff -Nru linux-2.6.0-test1.orig/drivers/block/as-iosched.c linux-2.6.0-test1-with_elevator_patch/drivers/block/as-iosched.c
> --- linux-2.6.0-test1.orig/drivers/block/as-iosched.c	2003-07-14 05:28:54.000000000 +0200
> +++ linux-2.6.0-test1-with_elevator_patch/drivers/block/as-iosched.c	2003-07-25 20:19:44.000000000 +0200
> @@ -1,7 +1,7 @@
>  /*
>   *  linux/drivers/block/as-iosched.c
>   *
> - *  Anticipatory & deadline i/o scheduler.
> + *  Anticipatory i/o scheduler.
>   *
>   *  Copyright (C) 2002 Jens Axboe <axboe@suse.de>
>   *                     Nick Piggin <piggin@cyberone.com.au>

Huh? What is that about? AS is deadline + anticipation. Good rule is not
to make comment changes when you don't know your changes to be a fact.

About making it selectable, I'm fine with it. Please send an updated
patch.

-- 
Jens Axboe

