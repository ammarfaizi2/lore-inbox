Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285137AbRLLKNd>; Wed, 12 Dec 2001 05:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285138AbRLLKNY>; Wed, 12 Dec 2001 05:13:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8465 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285137AbRLLKNG>;
	Wed, 12 Dec 2001 05:13:06 -0500
Date: Wed, 12 Dec 2001 11:12:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre10: Compilation failure in fdomain.c:1268: `io_request_lock' undeclared
Message-ID: <20011212101259.GD7562@suse.de>
In-Reply-To: <1008144756.20180.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008144756.20180.0.camel@stomata.megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12 2001, Miles Lane wrote:
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE  -DPCMCIA
> -D__NO_VERSION__ -c -o fdomain.o ../fdomain.c
> ../fdomain.c: In function `do_fdomain_16x0_intr':
> ../fdomain.c:1268: `io_request_lock' undeclared (first use in this
> function)
> ../fdomain.c:1268: (Each undeclared identifier is reported only once
> ../fdomain.c:1268: for each function it appears in.)
> make[3]: *** [fdomain.o] Error 1

If you want to be helpful with these, start making a list of what is
broken. If you send it to me, I'll make it public and comment each case
as to what needs doing.

-- 
Jens Axboe

