Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136751AbRECKrn>; Thu, 3 May 2001 06:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136752AbRECKrd>; Thu, 3 May 2001 06:47:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16650 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136751AbRECKrQ>;
	Thu, 3 May 2001 06:47:16 -0400
Date: Thu, 3 May 2001 12:46:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Shaun <delius@progsoc.uts.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk Performance Measurements
Message-ID: <20010503124647.F16507@suse.de>
In-Reply-To: <20010502124445.J25336@suse.de> <Pine.LNX.4.21.0105030750410.10591-100000@ftoomsh.progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105030750410.10591-100000@ftoomsh.progsoc.uts.edu.au>; from delius@progsoc.uts.edu.au on Thu, May 03, 2001 at 07:59:53AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03 2001, Shaun wrote:
> Again, this isn't the case in the 2.2.16 kernel I'm working with. Each
> call to make_request() causes pgin/pgout to be incremented, since these
> requests can be of different sizes (even for the same disk) I can't see
> how a kb value can be deduced. 

Check if the latest 2.2 is correct then, 2.4 is.

> Just as a question though, a disk/partition doesn't need to have a
> filesystem on it, so why is the "correct_size" for a buffer request on the
> block device defined based on a filesystem block system? 

It's not, but the fs may set the block size (ext2 does).

-- 
Jens Axboe

