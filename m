Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRB0JzJ>; Tue, 27 Feb 2001 04:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRB0Jy7>; Tue, 27 Feb 2001 04:54:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7899 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129643AbRB0Jyp>;
	Tue, 27 Feb 2001 04:54:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.21.0102251048280.25245-100000@weyl.math.psu.edu> 
In-Reply-To: <Pine.GSO.4.21.0102251048280.25245-100000@weyl.math.psu.edu> 
To: Alexander Viro <viro@math.psu.edu>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Feb 2001 09:50:47 +0000
Message-ID: <6769.983267447@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@math.psu.edu said:
> > Have you thought about supporting .tar.gz into ramfs? Creating custom
> > boot images would be simpler.

> *uh*. It's definitely easier to do than it used to be, but I'm
> seriously sceptical about adding more cruft into the thing.

The really neat part of untarring into a ramfs-root is that it allows you 
to remove a whole pile of other unnecessary cruft - ll_rw_blk and all the 
other crap for dealing with block devices and buffer_heads. 

CONFIG_BLK_DEV=n

--
dwmw2


