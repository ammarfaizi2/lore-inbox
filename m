Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263328AbSJCK42>; Thu, 3 Oct 2002 06:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSJCK42>; Thu, 3 Oct 2002 06:56:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6039 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263328AbSJCK4X>;
	Thu, 3 Oct 2002 06:56:23 -0400
Date: Thu, 3 Oct 2002 07:01:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block device size in 2.5
In-Reply-To: <20021003105610.GA12071@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0210030658201.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Joe Thornber wrote:

> Is gendisk the right name for that structure now ?  Since all block
> devices now have to use it.  I've always avoided using gendisk before,
> arguing that dm produces block devices, not disks.  I don't need
> partitions and I don't particularly want the devices to appear in
> /proc/partitions.

*shrug*  Probably we should change the name at some point.  struct gendisk
was the best starting point for creating such structure...

