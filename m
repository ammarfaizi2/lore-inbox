Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbUAaIJw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 03:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUAaIJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 03:09:52 -0500
Received: from [64.218.206.163] ([64.218.206.163]:36263 "HELO
	arumekun.no-ip.com") by vger.kernel.org with SMTP id S263891AbUAaIJu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 03:09:50 -0500
From: Luke-Jr <luke7jr@yahoo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
Date: Sat, 31 Jan 2004 08:09:39 +0000
User-Agent: KMail/1.5.94
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1075436665.2086.3.camel@laptop-linux> <200401310722.51472.luke7jr@yahoo.com> <1075534274.17730.65.camel@laptop-linux>
In-Reply-To: <1075534274.17730.65.camel@laptop-linux>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401310809.46256.luke7jr@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 31 January 2004 07:31 am, Nigel Cunningham wrote:
> http://prdownloads.sourceforge.net/swsusp/software-suspend-linux-2.6.1-rev6
>-whole.bz2?download
> http://prdownloads.sourceforge.net/swsusp/software-suspend-core-2.0-whole.b
>z2?download
> and (as the instructions on http://swsusp.sf.net say), apply them in
> that order.
After merging drivers/char/keyboard.c by hand (patch didn't like something):
  CC      init/do_mounts.o
init/do_mounts.c:6:27: linux/suspend.h: No such file or directory
In file included from include/linux/nfs_fs.h:15,
                 from init/do_mounts.c:10:
include/linux/pagemap.h:13:27: linux/suspend.h: No such file or directory
In file included from include/linux/nfs_fs.h:15,
                 from init/do_mounts.c:10:
include/linux/pagemap.h: In function `___add_to_page_cache':
include/linux/pagemap.h:150: error: `suspend_task' undeclared (first use in 
this function)
include/linux/pagemap.h:150: error: (Each undeclared identifier is reported 
only once
include/linux/pagemap.h:150: error: for each function it appears in.)
include/linux/pagemap.h:151: error: `last_suspend_cache_page' undeclared 
(first use in this function)
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAG2LIZl/BHdU+lYMRAsUrAKCYq15FX/pRdIi7OAH1IwEtUn5+eQCfdWp2
zFd+CIqpePi4+S54x1DIHPM=
=0QIi
-----END PGP SIGNATURE-----
