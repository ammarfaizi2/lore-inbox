Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289152AbSAGJDy>; Mon, 7 Jan 2002 04:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289153AbSAGJDp>; Mon, 7 Jan 2002 04:03:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61444 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289152AbSAGJDm>;
	Mon, 7 Jan 2002 04:03:42 -0500
Date: Mon, 7 Jan 2002 10:03:35 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.2-pre9/drivers/block/ll_rw_blk.c blk_rq_map_sg simplification
Message-ID: <20020107100335.A6940@suse.de>
In-Reply-To: <20020107005546.A2459@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020107005546.A2459@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07 2002, Adam J. Richter wrote:
> Hello Jens,
> 
> 	The following patch removes gotos from blk_rq_map_sg, making
> it more readable and five lines shorter.  I think the compiler should
> generate the same code.  I have not tested this other than to
> verify that it compiles.

Well, I really think the original is much more readable than the changed
version :-)

> 	Also, if there is some other way by which you would like
> me to submit future bio patches (if any), please let me know.

This is quite fine.

-- 
Jens Axboe

