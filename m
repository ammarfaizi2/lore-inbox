Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbRF0WSV>; Wed, 27 Jun 2001 18:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265433AbRF0WSL>; Wed, 27 Jun 2001 18:18:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59660 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265429AbRF0WR6>; Wed, 27 Jun 2001 18:17:58 -0400
Date: Wed, 27 Jun 2001 15:16:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <E15FNUb-0005wx-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106271514260.7355-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Jun 2001, Alan Cox wrote:

> > I find printk's with copyright notices quite disturbing. You will notice
> > that I don't have any myself. I think the whole thing is very tasteless,
> > and the "polite reminder" is just complete crap.
>
> If someone took all references to your name out of the kernel and put it out
> as 'Foobaros' by Foobarco you might take a different view.

I don't _have_ any instances of my name being printed out to annoy the
user, so that's a very theoretical argument.

> Intentionally or otherwise in the change thats what the JFFS argument is about.

This is my current patch in my tree. I refuse to have bickering in
printk's. You can edit the comment all you want.

		Linus

-----
diff -urN v2.4.5/linux/fs/jffs/inode-v23.c linux/fs/jffs/inode-v23.c
--- v2.4.5/linux/fs/jffs/inode-v23.c	Sun May 20 11:35:00 2001
+++ linux/fs/jffs/inode-v23.c	Wed Jun 27 13:51:50 2001
@@ -16,6 +16,7 @@
  * Ported to Linux 2.3.x and MTD:
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
  *
+ * Copyright 2000, 2001  Red Hat, Inc.
  */

 /* inode.c -- Contains the code that is called from the VFS.  */
@@ -1719,9 +1720,6 @@
 static int __init
 init_jffs_fs(void)
 {
-	printk("JFFS version "
-	       JFFS_VERSION_STRING
-	       ", (C) 1999, 2000  Axis Communications AB\n");
 	return register_filesystem(&jffs_fs_type);
 }


