Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRBBOIo>; Fri, 2 Feb 2001 09:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129648AbRBBOIe>; Fri, 2 Feb 2001 09:08:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25355 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129645AbRBBOIU>;
	Fri, 2 Feb 2001 09:08:20 -0500
Date: Fri, 2 Feb 2001 15:07:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        livid-dev@linuxvideo.org, Peter Rasmussen <plr@udgaard.com>
Subject: Re: [Patch] DVD bugfix in ide-cd.c
Message-ID: <20010202150752.F4261@suse.de>
In-Reply-To: <200102012210.XAA00328@udgaard.com> <sz2u26d4tt8.fsf@kazoo.cs.uiuc.edu> <sz2lmrp4qib.fsf_-_@kazoo.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sz2lmrp4qib.fsf_-_@kazoo.cs.uiuc.edu>; from vraalsen@cs.uiuc.edu on Thu, Feb 01, 2001 at 11:12:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01 2001, Fredrik Vraalsen wrote:
> 
> This is a small patch to Linux kernel 2.4.1 that fixes a problem with
> DVD playback in OMS (Open Media System).  With the stock 2.4.1 kernel
> OMS will only play up to a certain point on the DVD before it complains
> about no more data left on input (basically read() returns 0).  This
> patch reverts a change between 2.4.0 and 2.4.1.

Thanks applied, guess we need another work-around for buggy changers...

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
