Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759109AbWLAGA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759109AbWLAGA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbWLAGA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:00:29 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:60060 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1759106AbWLAGA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:00:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=FYwiKx7Odhp7QgmL/hTqO0248GVuQ2X+e8oWnN2UVSmDuzoJ1P0AcWemZnCZAk7qdy8CZDRxksU0r0J4vRk4IvQfXfRe3NI0Hv1BOjYx4KiuTh1Ty6RugE3pIht7GyaZomqeUUjdQzRyvMUllrleRTHax1/3Lz6olOQUiiPbmAI=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Adrian Bunk'" <bunk@stusta.de>, <tigran@aivazian.fsnet.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
Date: Thu, 30 Nov 2006 22:00:35 -0800
Message-ID: <00e401c7150e$061da500$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20061201055145.GK11084@stusta.de>
Thread-Index: AccVDRVVIzWhMggTSlecVa1Y/Zd/jwAAKzTg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am curious, what's the point?

These email addresses serve a "historical" purpose: they tell when the contribution was made,  what the author's email addresses
were at that point.

It's not MAINTAINERS. If people want to contact someone, go find the latest address there.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adrian Bunk
> Sent: Thursday, November 30, 2006 9:52 PM
> To: tigran@aivazian.fsnet.co.uk
> Cc: linux-kernel@vger.kernel.org
> Subject: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
> 
> This patch removes bouncing email addresses of Tigran 
> Aivazian from the kernel tree.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/filesystems/bfs.txt |    2 +-
>  arch/i386/kernel/microcode.c      |   28 ++++++++++++++--------------
>  arch/sh/kernel/kgdb_stub.c        |    2 +-
>  drivers/net/tlan.c                |    2 +-
>  fs/bfs/bfs.h                      |    2 +-
>  fs/bfs/dir.c                      |    2 +-
>  fs/bfs/file.c                     |    2 +-
>  fs/bfs/inode.c                    |    2 +-
>  fs/proc/kcore.c                   |    4 ++--
>  include/asm-sh/kgdb.h             |    2 +-
>  include/linux/bfs_fs.h            |    2 +-
>  mm/vmalloc.c                      |    2 +-
>  12 files changed, 26 insertions(+), 26 deletions(-)
> 
> --- linux-2.6.19-rc6-mm2/arch/i386/kernel/microcode.c.old	
> 2006-11-30 06:04:39.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/arch/i386/kernel/microcode.c	
> 2006-11-30 06:08:32.000000000 +0100
> @@ -20,25 +20,25 @@
>   *	as published by the Free Software Foundation; either version
>   *	2 of the License, or (at your option) any later version.
>   *
> - *	1.0	16 Feb 2000, Tigran Aivazian <tigran@sco.com>
> + *	1.0	16 Feb 2000, Tigran Aivazian
>   *		Initial release.
> - *	1.01	18 Feb 2000, Tigran Aivazian <tigran@sco.com>
> + *	1.01	18 Feb 2000, Tigran Aivazian 
>   *		Added read() support + cleanups.
> - *	1.02	21 Feb 2000, Tigran Aivazian <tigran@sco.com>
> + *	1.02	21 Feb 2000, Tigran Aivazian
>   *		Added 'device trimming' support. open(O_WRONLY) zeroes
>   *		and frees the saved copy of applied microcode.
> - *	1.03	29 Feb 2000, Tigran Aivazian <tigran@sco.com>
> + *	1.03	29 Feb 2000, Tigran Aivazian
>   *		Made to use devfs (/dev/cpu/microcode) + cleanups.
>   *	1.04	06 Jun 2000, Simon Trimmer <simon@veritas.com>
>   *		Added misc device support (now uses both devfs 
> and misc).
>   *		Added MICROCODE_IOCFREE ioctl to clear memory.
>   *	1.05	09 Jun 2000, Simon Trimmer <simon@veritas.com>
>   *		Messages for error cases (non Intel & no 
> suitable microcode).
> - *	1.06	03 Aug 2000, Tigran Aivazian <tigran@veritas.com>
> + *	1.06	03 Aug 2000, Tigran Aivazian
>   *		Removed ->release(). Removed exclusive open and 
> status bitmap.
>   *		Added microcode_rwsem to serialize 
> read()/write()/ioctl().
>   *		Removed global kernel lock usage.
> - *	1.07	07 Sep 2000, Tigran Aivazian <tigran@veritas.com>
> + *	1.07	07 Sep 2000, Tigran Aivazian
>   *		Write 0 to 0x8B msr and then cpuid before 
> reading revision,
>   *		so that it works even if there were no update 
> done by the
>   *		BIOS. Otherwise, reading from 0x8B gives junk 
> (which happened
> @@ -46,26 +46,26 @@
>   *		disabled update by the BIOS)
>   *		Thanks to Eric W. Biederman 
> <ebiederman@lnxi.com> for the fix.
>   *	1.08	11 Dec 2000, Richard Schaal 
> <richard.schaal@intel.com> and
> - *			     Tigran Aivazian <tigran@veritas.com>
> + *			     Tigran Aivazian
>   *		Intel Pentium 4 processor support and bugfixes.
> - *	1.09	30 Oct 2001, Tigran Aivazian <tigran@veritas.com>
> + *	1.09	30 Oct 2001, Tigran Aivazian 
>   *		Bugfix for HT (Hyper-Threading) enabled processors
>   *		whereby processor resources are shared by all 
> logical processors
>   *		in a single CPU package.
>   *	1.10	28 Feb 2002 Asit K Mallick 
> <asit.k.mallick@intel.com> and
> - *		Tigran Aivazian <tigran@veritas.com>,
> + *		Tigran Aivazian 
>   *		Serialize updates as required on HT processors 
> due to speculative
>   *		nature of implementation.
> - *	1.11	22 Mar 2002 Tigran Aivazian <tigran@veritas.com>
> + *	1.11	22 Mar 2002 Tigran Aivazian
>   *		Fix the panic when writing zero-length microcode chunk.
>   *	1.12	29 Sep 2003 Nitin Kamble <nitin.a.kamble@intel.com>, 
>   *		Jun Nakajima <jun.nakajima@intel.com>
>   *		Support for the microcode updates in the new format.
> - *	1.13	10 Oct 2003 Tigran Aivazian <tigran@veritas.com>
> + *	1.13	10 Oct 2003 Tigran Aivazian
>   *		Removed ->read() method and obsoleted 
> MICROCODE_IOCFREE ioctl
>   *		because we no longer hold a copy of applied microcode 
>   *		in kernel memory.
> - *	1.14	25 Jun 2004 Tigran Aivazian <tigran@veritas.com>
> + *	1.14	25 Jun 2004 Tigran Aivazian
>   *		Fix sigmatch() macro to handle old CPUs with pf == 0.
>   *		Thanks to Stuart Swales for pointing out this bug.
>   */
> @@ -92,7 +92,7 @@
>  #include <asm/processor.h>
>  
>  MODULE_DESCRIPTION("Intel CPU (IA-32) Microcode Update 
> Driver"); -MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
> +MODULE_AUTHOR("Tigran Aivazian");
>  MODULE_LICENSE("GPL");
>  
>  #define MICROCODE_VERSION 	"1.14a"
> @@ -752,7 +752,7 @@
>  	register_hotcpu_notifier(&mc_cpu_notifier);
>  
>  	printk(KERN_INFO 
> -		"IA-32 Microcode Update Driver: v" 
> MICROCODE_VERSION " <tigran@veritas.com>\n");
> +		"IA-32 Microcode Update Driver: v" 
> MICROCODE_VERSION "\n");
>  	return 0;
>  }
>  
> --- 
> linux-2.6.19-rc6-mm2/Documentation/filesystems/bfs.txt.old	
> 2006-11-30 06:07:30.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/Documentation/filesystems/bfs.txt	
> 2006-11-30 06:08:00.000000000 +0100
> @@ -54,4 +54,4 @@
>  If you have any patches, questions or suggestions regarding 
> this BFS  implementation please contact the author:
>  
> -Tigran A. Aivazian <tigran@veritas.com>
> +Tigran A. Aivazian <tigran@aivazian.fsnet.co.uk>
> --- linux-2.6.19-rc6-mm2/arch/sh/kernel/kgdb_stub.c.old	
> 2006-11-30 06:08:47.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/arch/sh/kernel/kgdb_stub.c	
> 2006-11-30 06:08:58.000000000 +0100
> @@ -3,7 +3,7 @@
>   * License.  See linux/COPYING for more information.
>   *
>   * Containes extracts from code by Glenn Engel, Jim Kingdon,
> - * David Grothe <dave@gcom.com>, Tigran Aivazian <tigran@sco.com>,
> + * David Grothe <dave@gcom.com>, Tigran Aivazian,
>   * Amit S. Kale <akale@veritas.com>,  William Gatliff 
> <bgat@open-widgets.com>,
>   * Ben Lee, Steve Chamberlain and Benoit Miller <fulg@iname.com>.
>   * 
> --- linux-2.6.19-rc6-mm2/drivers/net/tlan.c.old	
> 2006-11-30 06:09:09.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/drivers/net/tlan.c	2006-11-30 
> 06:09:26.000000000 +0100
> @@ -29,7 +29,7 @@
>   *
>   * Change History
>   *
> - *	Tigran Aivazian <tigran@sco.com>:	TLan_PciProbe() now uses
> + *	Tigran Aivazian	                 :	TLan_PciProbe() now uses
>   *						new PCI BIOS interface.
>   *	Alan Cox	<alan@redhat.com>:	Fixed the out of memory
>   *						handling.
> --- linux-2.6.19-rc6-mm2/fs/bfs/bfs.h.old	2006-11-30 
> 06:09:35.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/bfs/bfs.h	2006-11-30 
> 06:09:40.000000000 +0100
> @@ -1,6 +1,6 @@
>  /*
>   *	fs/bfs/bfs.h
> - *	Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
> + *	Copyright (C) 1999 Tigran Aivazian
>   */
>  #ifndef _FS_BFS_BFS_H
>  #define _FS_BFS_BFS_H
> --- linux-2.6.19-rc6-mm2/fs/bfs/dir.c.old	2006-11-30 
> 06:09:46.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/bfs/dir.c	2006-11-30 
> 06:09:51.000000000 +0100
> @@ -1,7 +1,7 @@
>  /*
>   *	fs/bfs/dir.c
>   *	BFS directory operations.
> - *	Copyright (C) 1999,2000  Tigran Aivazian <tigran@veritas.com>
> + *	Copyright (C) 1999,2000  Tigran Aivazian
>   *      Made endianness-clean by Andrew Stribblehill 
> <ads@wompom.org> 2005
>   */
>  
> --- linux-2.6.19-rc6-mm2/fs/bfs/file.c.old	2006-11-30 
> 06:09:57.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/bfs/file.c	2006-11-30 
> 06:10:02.000000000 +0100
> @@ -1,7 +1,7 @@
>  /*
>   *	fs/bfs/file.c
>   *	BFS file operations.
> - *	Copyright (C) 1999,2000 Tigran Aivazian <tigran@veritas.com>
> + *	Copyright (C) 1999,2000 Tigran Aivazian
>   */
>  
>  #include <linux/fs.h>
> --- linux-2.6.19-rc6-mm2/fs/bfs/inode.c.old	2006-11-30 
> 06:10:11.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/bfs/inode.c	2006-11-30 
> 06:10:16.000000000 +0100
> @@ -1,7 +1,7 @@
>  /*
>   *	fs/bfs/inode.c
>   *	BFS superblock and inode operations.
> - *	Copyright (C) 1999,2000 Tigran Aivazian <tigran@veritas.com>
> + *	Copyright (C) 1999,2000 Tigran Aivazian
>   *	From fs/minix, Copyright (C) 1991, 1992 Linus Torvalds.
>   *
>   *      Made endianness-clean by Andrew Stribblehill 
> <ads@wompom.org>, 2005.
> --- linux-2.6.19-rc6-mm2/fs/proc/kcore.c.old	2006-11-30 
> 06:10:43.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/proc/kcore.c	2006-11-30 
> 06:11:00.000000000 +0100
> @@ -4,8 +4,8 @@
>   *	Modelled on fs/exec.c:aout_core_dump()
>   *	Jeremy Fitzhardinge <jeremy@sw.oz.au>
>   *	ELF version written by David Howells <David.Howells@nexor.co.uk>
> - *	Modified and incorporated into 2.3.x by Tigran Aivazian 
> <tigran@veritas.com>
> - *	Support to dump vmalloc'd areas (ELF only), Tigran 
> Aivazian <tigran@veritas.com>
> + *	Modified and incorporated into 2.3.x by Tigran Aivazian
> + *	Support to dump vmalloc'd areas (ELF only), Tigran Aivazian
>   *	Safe accesses to vmalloc/direct-mapped discontiguous 
> areas, Kanoj Sarcar <kanoj@sgi.com>
>   */
>  
> --- linux-2.6.19-rc6-mm2/include/asm-sh/kgdb.h.old	
> 2006-11-30 06:11:08.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/include/asm-sh/kgdb.h	
> 2006-11-30 06:11:16.000000000 +0100
> @@ -3,7 +3,7 @@
>   * License.  See linux/COPYING for more information.
>   *
>   * Based on original code by Glenn Engel, Jim Kingdon,
> - * David Grothe <dave@gcom.com>, Tigran Aivazian, 
> <tigran@sco.com> and
> + * David Grothe <dave@gcom.com>, Tigran Aivazian, and
>   * Amit S. Kale <akale@veritas.com>
>   *
>   * Super-H port based on sh-stub.c (Ben Lee and Steve Chamberlain) by
> --- linux-2.6.19-rc6-mm2/include/linux/bfs_fs.h.old	
> 2006-11-30 06:11:26.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/include/linux/bfs_fs.h	
> 2006-11-30 06:11:31.000000000 +0100
> @@ -1,6 +1,6 @@
>  /*
>   *	include/linux/bfs_fs.h - BFS data structures on disk.
> - *	Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
> + *	Copyright (C) 1999 Tigran Aivazian
>   */
>  
>  #ifndef _LINUX_BFS_FS_H
> --- linux-2.6.19-rc6-mm2/mm/vmalloc.c.old	2006-11-30 
> 06:11:38.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/mm/vmalloc.c	2006-11-30 
> 06:11:46.000000000 +0100
> @@ -3,7 +3,7 @@
>   *
>   *  Copyright (C) 1993  Linus Torvalds
>   *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
> - *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian 
> <tigran@veritas.com>, May 2000
> + *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian, May 2000
>   *  Major rework to support vmap/vunmap, Christoph Hellwig, 
> SGI, August 2002
>   *  Numa awareness, Christoph Lameter, SGI, June 2005
>   */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

