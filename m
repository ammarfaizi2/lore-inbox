Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271642AbRIBQpv>; Sun, 2 Sep 2001 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271643AbRIBQpm>; Sun, 2 Sep 2001 12:45:42 -0400
Received: from jupter.networx.com.br ([200.187.100.102]:9877 "EHLO
	jupter.networx.com.br") by vger.kernel.org with ESMTP
	id <S271642AbRIBQp3>; Sun, 2 Sep 2001 12:45:29 -0400
Message-Id: <200109021637.f82GbZO24110@jupter.networx.com.br>
Content-Type: text/plain;
  charset="iso-8859-2"
From: Thiago Vinhas de Moraes <tvlists@networx.com.br>
Organization: NetWorx - A SuaCompanhia.com
To: Adam Popik <popik@ap.popik.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: VMware and kernel 2.4.7,8,9
Date: Sun, 2 Sep 2001 13:38:48 -0300
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109021239510.11190-100000@ap.popik.pl>
In-Reply-To: <Pine.LNX.4.33.0109021239510.11190-100000@ap.popik.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Vmware is a parasite. Their modules are vmware responsability.

I found a modified vmmon and vmnet on their Usenet post. Try news.vmware.com, 
on the experimental group.

Regards,
Thiago

Em Dom, 02 de Set de 2001 07:41, Adam Popik escreveu:
> What was changed in this kernels ? I cannot compile modules for vmware.
> errors:
> /usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
> In file included from /usr/src/linux/include/linux/highmem.h:5,
>                  from /usr/src/linux/include/linux/pagemap.h:16,
>                  from /usr/src/linux/include/linux/locks.h:8,
>                  from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
>                  from /usr/src/linux/include/linux/miscdevice.h:4,
>                  from ../linux/driver.h:10,
>                  from .././linux/driver.c:58:
> /usr/src/linux/include/asm/pgalloc.h:56: `PAGE_OFFSET' undeclared (first
> use in
> /usr/src/linux/include/asm/pgalloc.h:56: (Each undeclared identifier is
> reported/usr/src/linux/include/asm/pgalloc.h:56: for each function it
> appears in.)
> /usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
> /usr/src/linux/include/asm/pgalloc.h:103: `PAGE_SIZE' undeclared (first
> use in t/usr/src/linux/include/linux/highmem.h: In function
> `clear_user_highpage':
> In file included from /usr/src/linux/include/linux/pagemap.h:16,
>                  from /usr/src/linux/include/linux/locks.h:8,
>                  from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
>                  from /usr/src/linux/include/linux/miscdevice.h:4,
>                  from ../linux/driver.h:10,
>                  from .././linux/driver.c:58:
> /usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
> /usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
> /usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function
> `memclear_highpage_flush':
> /usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
> In file included from /usr/src/linux/include/linux/pagemap.h:16,
>                  from /usr/src/linux/include/linux/locks.h:8,
>                  from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
>                  from /usr/src/linux/include/linux/miscdevice.h:4,
>                  from ../linux/driver.h:10,
>                  from .././linux/driver.c:58:
> /usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
> /usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
> /usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function
> `memclear_highpage_flush':
> /usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
> /usr/src/linux/include/linux/highmem.h:90: `PAGE_SIZE' undeclared (first
> use in
> /usr/src/linux/include/linux/highmem.h: In function `copy_highpage':
> /usr/src/linux/include/linux/highmem.h:101: `PAGE_SIZE' undeclared (first
> use in.././linux/driver.c: In function `LinuxDriver_Ioctl':
> .././linux/driver.c:928: structure has no member named `dumpable'
> make[1]: *** [driver.o] B³±d 1
> make: *** [driver] B³±d 2
>
> Adam
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
