Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDUOVE>; Sat, 21 Apr 2001 10:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbRDUOUy>; Sat, 21 Apr 2001 10:20:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8200 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132636AbRDUOUu>;
	Sat, 21 Apr 2001 10:20:50 -0400
Date: Sat, 21 Apr 2001 16:20:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        linux-lvm@sistina.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] lvm beta7 and ac11 problems
Message-ID: <20010421162003.F26732@suse.de>
In-Reply-To: <01042110002200.00707@oscar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01042110002200.00707@oscar>; from tomlins@cam.org on Sat, Apr 21, 2001 at 10:00:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21 2001, Ed Tomlinson wrote:
> Hi,
> 
> building a kernel with 2.4.3-ac11 and lvm beta7 + vfs_locking_patch-2.4.2 yields:
> 
> oscar# depmod -ae 2.4.3-ac11 
> depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac11/kernel/drivers/md/lvm-mod.o
> depmod:         get_hardblocksize
> 
> ideas?

s/get_hardblocksize/get_hardsect_size

-- 
Jens Axboe

