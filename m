Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbQLRAtL>; Sun, 17 Dec 2000 19:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbQLRAtC>; Sun, 17 Dec 2000 19:49:02 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:5042 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S132798AbQLRAsp>;
	Sun, 17 Dec 2000 19:48:45 -0500
Date: Mon, 18 Dec 2000 01:17:39 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre3 and ext2 as module
In-Reply-To: <E147nq8-0004lF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012180116450.26302-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Alan Cox wrote:

> > I compiled test13-pre3 a few minutes ago and when running
> > make modules_install I got this:
> > 
> > depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/fs/ext2/ext2.o
> > depmod:         buffer_insert_inode_queue
> > depmod:         fsync_inode_buffers
> 
> Jeff Raubitschek posted a patch for this on the 12th. 

Thanks for the quick response, testing the patch now.
If it works I'll ask Linux to include it in the next pre-patch

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
