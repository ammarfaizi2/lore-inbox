Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310160AbSBRHCH>; Mon, 18 Feb 2002 02:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSBRHB5>; Mon, 18 Feb 2002 02:01:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8972 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310160AbSBRHBp>;
	Mon, 18 Feb 2002 02:01:45 -0500
Date: Mon, 18 Feb 2002 08:01:29 +0100
From: Jens Axboe <axboe@suse.de>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5pre1 /drivers/block/rd.c using nr_sectors
Message-ID: <20020218070129.GA25111@suse.de>
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F1C@nocmail.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F1C@nocmail.ma.tmpw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15 2002, Holzrichter, Bruce wrote:
> Not sure if your the one to contact, but compiling 2.5.5pre1 errored out
> compiling the ramdisk driver in /drivers/block/rd.c because it is still
> using bi_end_io with the nr_sectors Argument.  I simply removed the
> nr_sectors arg to make the kernel compile past that point.  I don't know if
> that's the right route to go, but wanted to let someone know. 

That's the right fix

-- 
Jens Axboe

