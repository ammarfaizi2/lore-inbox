Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHKKQd>; Sun, 11 Aug 2002 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSHKKQc>; Sun, 11 Aug 2002 06:16:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318289AbSHKKPr>;
	Sun, 11 Aug 2002 06:15:47 -0400
Date: Sun, 11 Aug 2002 12:19:14 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.31/include/linux/blkdev.h paranethesis problem in BLK__DEFAULT_QUEUE
Message-ID: <20020811101914.GJ8755@suse.de>
References: <20020811001659.A25279@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811001659.A25279@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11 2002, Adam J. Richter wrote:
> Hi Jens,
> 
> 	The following trivial fix has been in my kernel tree for
> ages.  It is need for the C compiler to compile statements like
> the following, which I use in my version of loop.c:
> 
> 	BLK_DEFAULT_QUEUE(MAJOR_NR)->queuedata = NULL;
> 
> 	Could you please apply it to your tree and forward it to
> Linus (or let me know if you'd prefer to handle it some other way).

Trivially correct, just go ahead and send it to Linus. Thanks.

-- 
Jens Axboe

