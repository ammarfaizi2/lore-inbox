Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRH1IKn>; Tue, 28 Aug 2001 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRH1IKd>; Tue, 28 Aug 2001 04:10:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12303 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S270075AbRH1IKQ>; Tue, 28 Aug 2001 04:10:16 -0400
Message-ID: <3B8B50D4.2BC8A182@evision-ventures.com>
Date: Tue, 28 Aug 2001 10:05:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.GSO.4.21.0108271640590.29700-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Patch fixes the use of ioctls in partitions/ibm.c, removing
> a lot of junk in process (fake struct file allocation, set_fs(),
> yodda, yodda - we use blkdev_get() and ioctl_by_bdev() instead).
> Please, apply

Well It is a while ago that I was claiming that the IBM blk-dev handling
code seems to be done by someone who got a bit confused... Thank you
for working on fixing this!
