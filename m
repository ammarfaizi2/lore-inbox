Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSKBVeQ>; Sat, 2 Nov 2002 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSKBVeP>; Sat, 2 Nov 2002 16:34:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3970 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261443AbSKBVeN>;
	Sat, 2 Nov 2002 16:34:13 -0500
Date: Sat, 2 Nov 2002 22:40:14 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: thornber@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.5.45): move io_restrictions to blkdev.h
Message-ID: <20021102214014.GF3612@suse.de>
References: <20021102105119.A6865@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102105119.A6865@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Adam J. Richter wrote:
> 	This patch makes good on a threat that I posted yesterday
> to move struct io_restrictions from <linux/device-mapper.h> to
> <linux/blkdev.h>, eliminating duplication of a list of fields in
> struct request_queue.

Adam, I generally think the patch is a good idea. I also think it's a
very stupid time to start messing with stuff that is basically trivial
but still touches lost of stuff.

Please leave it alone for a few weeks.

> 	Jens, can I persuade you to integrate this change?

In due time, yes.

-- 
Jens Axboe

