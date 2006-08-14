Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWHNITn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWHNITn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWHNITn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:19:43 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:46464 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP
	id S1751931AbWHNITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:19:42 -0400
Subject: Re: 2.6.18-rc4-mm1
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060813133935.b0c728ec.akpm@osdl.org>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813133935.b0c728ec.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 16:06:45 +0800
Message-Id: <1155542805.3430.5.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I'm having trouble duplicating this.
Is there any more info. about this I'm missing?

[raven@raven ~]$ /usr/sbin/showmount -e budgie
Export list for budgie:
/        *
/usr/src *
[raven@raven ~]$

[raven@raven ~]$ cd /net/budgie
[raven@raven budgie]$ ls -l
total 116
drwxrwxrwx 10 root root  4096 Jul 15 13:23 autofs
drwxr-xr-x  2 root root  4096 Oct 31  2004 bin
drwxr-xr-x  2 root root  4096 Jan  5  2005 boot
drwxr-xr-x  2 root root  4096 Oct 19  2003 cdrom
drwxr-xr-x 11 root root 24576 Aug 14 08:48 dev
drwxr-xr-x 65 root root  8192 Aug 14 08:49 etc
drwxr-xr-x  2 root root  4096 Oct 19  2003 floppy
drwxrwsr-x  5 root ftp   4096 Apr  3 19:42 home
drwxr-xr-x  2 root root  4096 Oct 19  2003 initrd
lrwxrwxrwx  1 root root    28 Oct 31  2004 initrd.img ->
boot/initrd.img-2.4.27-1-386
lrwxrwxrwx  1 root root    29 Oct 19  2003 initrd.img.old
-> /boot/initrd.img-2.4.18-1-386
drwxr-xr-x  7 root root  4096 Oct 30  2005 lib
drwx------  2 root root 16384 Oct 19  2003 lost+found
drwxr-xr-x  5 root root  4096 Dec 19  2004 mnt
drwxr-xr-x  2 root root  4096 Oct 19  2003 opt
drwxr-xr-x  2 root root  4096 Feb  8  2002 proc
drwxr-xr-x  7 root root  4096 Oct 30  2005 root
drwxr-xr-x  2 root root  4096 Oct 30  2005 sbin
drwxr-xr-x  2 root root  4096 Oct 14  2004 sys
drwxrwxrwt  4 root root  4096 Aug 14 12:49 tmp
drwxr-xr-x 12 root root  4096 Oct 31  2004 usr
drwxr-xr-x 15 root root  4096 Oct 31  2004 var
lrwxrwxrwx  1 root root    25 Oct 31  2004 vmlinuz ->
boot/vmlinuz-2.4.27-1-386
lrwxrwxrwx  1 root root    25 Oct 19  2003 vmlinuz.old ->
boot/vmlinuz-2.4.18-1-386
[raven@raven budgie]$

[raven@raven budgie]$ cd usr/src
[raven@raven src]$ ls -l
total 49660
drwxr-xr-x  5 root root     4096 Dec 25  2004 kernel-headers-2.4.27-1
drwxr-xr-x  3 root root     4096 Dec 26  2004
kernel-headers-2.4.27-1-386
-rw-r--r--  1 root root  4685364 Dec 25  2004
kernel-headers-2.4.27-1-386_1_i386.deb
-rw-r--r--  1 root root 11270432 Dec 26  2004
kernel-image-2.4.27-1-386_1_i386.deb
drwxr-xr-x  3 root root     4096 Dec 19  2004 kernel-patches
drwxr-xr-x 16 root root     4096 Dec 26  2004 kernel-source-2.4.27
-rw-r--r--  1 root root 30980829 Dec  1  2004
kernel-source-2.4.27.tar.bz2
drwx------  2 root root    16384 Dec 19  2004 lost+found
-rw-r--r--  1 root root   145984 Dec 26  2004
madwifi-module-2.4.27-1-386_20041216-1-onoe+1_i386.deb
-rw-r--r--  1 root root  1692484 Dec 26  2004
madwifi-source_20041216_all.deb
-rw-r--r--  1 root root  1680344 Dec 16  2004 madwifi.tar.gz
-rw-r--r--  1 root root    14828 Dec 26  2004
madwifi-tools_20041216_i386.deb
drwxr-xr-x  4 root root     4096 Dec 16  2004 modules
-rw-r--r--  1 root root    55752 Dec 26  2004
ndiswrapper-modules-2.4.27-1-386_0.11-1+1_i386.deb
-rw-r--r--  1 root root    84130 Dec 26  2004
ndiswrapper-source_0.11-1_i386.deb
-rw-r--r--  1 root root    76469 Nov  8  2004 ndiswrapper-source.tar.bz2
-rw-r--r--  1 root root    20086 Dec 26  2004
ndiswrapper-utils_0.11-1_i386.deb


On Sun, 2006-08-13 at 13:39 -0700, Andrew Morton wrote:
> On Sun, 13 Aug 2006 01:24:54 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> This kernel breaks autofs /net handling.  Bisection shows that the bug is
> introduced by git-nfs.patch.
> 
> 
> sony:/home/akpm> showmount -e bix
> Export list for bix:
> /           *
> /usr/src    *
> /mnt/export *
> sony:/home/akpm> ls -l /net/bix
> total 1025280
> drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
> drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
> drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
> drwxr-xr-x 98 root root       8192 Aug 13 04:03 etc
> drwxr-xr-x  7 root root       4096 Apr  1  2004 home
> drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
> drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
> drwx------  2 root root      16384 Mar 10  2004 lost+found
> drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
> ?---------  ? ?    ?             ?            ? /net/bix/mnt
> ?---------  ? ?    ?             ?            ? /net/bix/usr
> drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
> drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
> drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
> drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
> drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
> -rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
> drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
> drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
> drwxrwxrwt 14 root root      16384 Aug 13 13:29 tmp
> drwxr-xr-x 27 root root       4096 Mar 10  2004 var
> sony:/home/akpm> ls -l /net/bix/usr
> ls: /net/bix/usr: No such file or directory
> sony:/home/akpm> mount     
> /dev/sda6 on / type ext3 (rw,noatime)
> /dev/proc on /proc type proc (rw)
> /dev/sys on /sys type sysfs (rw)
> /dev/devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/shm on /dev/shm type tmpfs (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> automount(pid1757) on /net type autofs (rw,fd=5,pgrp=1757,minproto=2,maxproto=4)
> bix:/ on /net/bix type nfs (rw,nosuid,nodev,hard,intr,tcp,addr=192.168.2.33)
> 
> 
> distro is fairly-up-to-date FC5.

