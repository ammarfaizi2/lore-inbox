Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289182AbSAGNCu>; Mon, 7 Jan 2002 08:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289181AbSAGNCl>; Mon, 7 Jan 2002 08:02:41 -0500
Received: from ns.suse.de ([213.95.15.193]:1804 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289171AbSAGNCZ>;
	Mon, 7 Jan 2002 08:02:25 -0500
Date: Mon, 7 Jan 2002 14:02:24 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.2-pre9/drivers/block/ll_rw_blk.c blk_rq_map_sg
 simplification
In-Reply-To: <20020107100335.A6940@suse.de>
Message-ID: <Pine.LNX.4.33.0201071401290.14473-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Jens Axboe wrote:

> > 	The following patch removes gotos from blk_rq_map_sg, making
> > it more readable and five lines shorter.  I think the compiler should
> > generate the same code.  I have not tested this other than to
> > verify that it compiles.
> Well, I really think the original is much more readable than the changed
> version :-)

I agree. Upon seeing the patch, I was reminded of the monster
enormous conditional at http://gcc.gnu.org/projects/beginner.html
not quite _that_ bad, but getting there 8)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

