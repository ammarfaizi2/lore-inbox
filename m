Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271396AbTHDGoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 02:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271398AbTHDGoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 02:44:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7139 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271396AbTHDGoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 02:44:05 -0400
Date: Mon, 4 Aug 2003 08:43:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Clemens Schwaighofer <schwaigl@eunet.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 from csv fails to compile
Message-ID: <20030804064358.GA854@suse.de>
References: <200308041313.52755.schwaigl@eunet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308041313.52755.schwaigl@eunet.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04 2003, Clemens Schwaighofer wrote:
> csv checkout from today (2003/08/04 ~11:00 JST)
> 
> make -f scripts/Makefile.build obj=drivers/block
>   gcc -Wp,-MD,drivers/block/.ll_rw_blk.o.d -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
> -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=ll_rw_blk -DKBUILD_MODNAME=ll_rw_blk -c -o 
> drivers/block/ll_rw_blk.o drivers/block/ll_rw_blk.c
> drivers/block/ll_rw_blk.c: In function `blk_init_queue':
> drivers/block/ll_rw_blk.c:1275: structure has no member named `elevator_name'
> make[2]: *** [drivers/block/ll_rw_blk.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2
> 
> the previews worked fine (last checkout I did around 5 days ago). in this 
> compile I added Raid system, Raiser, JFS) just for compile check ...

your source is screwed, save you config and try again with another
checkout.

-- 
Jens Axboe

