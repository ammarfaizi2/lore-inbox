Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130098AbRAaSm2>; Wed, 31 Jan 2001 13:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRAaSmT>; Wed, 31 Jan 2001 13:42:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12304 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130098AbRAaSmL>;
	Wed, 31 Jan 2001 13:42:11 -0500
Date: Wed, 31 Jan 2001 19:41:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: "'bert hubert'" <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: drive/block device write scheduling, buffer flushing?
Message-ID: <20010131194155.U508@suse.de>
In-Reply-To: <8FED3D71D1D2D411992A009027711D671880@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FED3D71D1D2D411992A009027711D671880@md>; from NBlack@md.aacisd.com on Wed, Jan 31, 2001 at 01:29:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31 2001, Nathan Black wrote:
> That is what I wanted to do...Write directly to the disk. But the
> kernel(2.4.1) is caching the io...

Bind the block device to a /dev/raw* and do I/O on that

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
