Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbRFKFhJ>; Mon, 11 Jun 2001 01:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbRFKFgx>; Mon, 11 Jun 2001 01:36:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41905 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263423AbRFKFgR>;
	Mon, 11 Jun 2001 01:36:17 -0400
Date: Mon, 11 Jun 2001 01:36:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/super.c stuff (3/10)
In-Reply-To: <Pine.GSO.4.21.0106110134230.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110135430.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Grr... 4 of 10, that is. Sorry.

On Mon, 11 Jun 2001, Alexander Viro wrote:

> diff -urN S6-pre2-fsync_no_super/include/linux/fs.h S6-pre2-put_super/include/linux/fs.h
> --- S6-pre2-fsync_no_super/include/linux/fs.h	Sun Jun 10 18:36:27 2001
> +++ S6-pre2-put_super/include/linux/fs.h	Sun Jun 10 18:39:04 2001
> @@ -1320,7 +1320,6 @@
>  
>  extern struct file_system_type *get_fs_type(const char *name);
>  extern struct super_block *get_super(kdev_t);
> -extern void put_super(kdev_t);
>  static inline int is_mounted(kdev_t dev)
>  {
>  	struct super_block *sb = get_super(dev);
> 
> 
> 

