Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDWJEF>; Mon, 23 Apr 2001 05:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDWJDy>; Mon, 23 Apr 2001 05:03:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36624 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131587AbRDWJDo>; Mon, 23 Apr 2001 05:03:44 -0400
Message-ID: <3AE3ED20.FD685CE@evision-ventures.com>
Date: Mon, 23 Apr 2001 10:51:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org, linux-lvm@sistina.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] lvm beta7 and ac11 problems
In-Reply-To: <01042110002200.00707@oscar> <20010421162003.F26732@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sat, Apr 21 2001, Ed Tomlinson wrote:
> > Hi,
> >
> > building a kernel with 2.4.3-ac11 and lvm beta7 + vfs_locking_patch-2.4.2 yields:
> >
> > oscar# depmod -ae 2.4.3-ac11
> > depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac11/kernel/drivers/md/lvm-mod.o
> > depmod:         get_hardblocksize
> >
> > ideas?
> 
> s/get_hardblocksize/get_hardsect_size

And don't forget to have a look whatever the get_hardblocksize == 0
check
or similar can't be killed alltogether as well....
