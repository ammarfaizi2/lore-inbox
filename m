Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270293AbRHRSJ5>; Sat, 18 Aug 2001 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270279AbRHRSJr>; Sat, 18 Aug 2001 14:09:47 -0400
Received: from [209.38.98.99] ([209.38.98.99]:12761 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S270274AbRHRSJe>;
	Sat, 18 Aug 2001 14:09:34 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Fred Jackson <fred@arkansaswebs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 13:07:58 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081812570001.09229@bits.linuxball>
In-Reply-To: <01081812570001.09229@bits.linuxball>
MIME-Version: 1.0
Message-Id: <01081813075802.09229@bits.linuxball>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

additional info

recompiling results in parse errors immediately.
output follows
________________________________________________________
[root@bits linux]# make bzImage
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o 
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/b2/sw/linux-2.4.9/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6   -c -o init/main.o init/main.c
In file included from /b2/sw/linux-2.4.9/include/linux/fs.h:19,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/dcache.h: In function `dget':
/b2/sw/linux-2.4.9/include/linux/dcache.h:244: warning: implicit 
declaration of function `printk'
In file included from /b2/sw/linux-2.4.9/include/asm/semaphore.h:39,
                 from /b2/sw/linux-2.4.9/include/linux/fs.h:198,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/asm/system.h: At top level:
/b2/sw/linux-2.4.9/include/asm/system.h:12: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/rwsem.h:27,
                 from /b2/sw/linux-2.4.9/include/asm/semaphore.h:42,
                 from /b2/sw/linux-2.4.9/include/linux/fs.h:198,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/asm/rwsem.h:46: parse error before `('
/b2/sw/linux-2.4.9/include/asm/rwsem.h:47: parse error before `('
/b2/sw/linux-2.4.9/include/asm/rwsem.h:48: parse error before `('
In file included from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/fs.h: In function `put_bh':
/b2/sw/linux-2.4.9/include/linux/fs.h:1082: warning: implicit 
declaration of function `barrier'
/b2/sw/linux-2.4.9/include/linux/fs.h: At top level:
/b2/sw/linux-2.4.9/include/linux/fs.h:1123: parse error before `('
/b2/sw/linux-2.4.9/include/linux/fs.h:1124: parse error before `('
/b2/sw/linux-2.4.9/include/linux/fs.h: In function 
`mark_buffer_dirty_inode':
/b2/sw/linux-2.4.9/include/linux/fs.h:1146: warning: implicit 
declaration of function `mark_buffer_dirty'
In file included from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/sched.h: At top level:
/b2/sw/linux-2.4.9/include/linux/sched.h:153: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/sched.h:551: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:552: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:553: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:554: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:556: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:557: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:559: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:721: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h: In function `mmdrop':
/b2/sw/linux-2.4.9/include/linux/sched.h:725: warning: implicit 
declaration of function `__mmdrop' 
/b2/sw/linux-2.4.9/include/linux/sched.h: At top level:
/b2/sw/linux-2.4.9/include/linux/sched.h:757: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:758: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:759: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/mm.h:383: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:384: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h: In function `alloc_pages':
/b2/sw/linux-2.4.9/include/linux/mm.h:394: warning: implicit 
declaration of function 
`_alloc_pages'/b2/sw/linux-2.4.9/include/linux/mm.h:394: warning: 
return makes pointer from integer without a cast
/b2/sw/linux-2.4.9/include/linux/mm.h: At top level:
/b2/sw/linux-2.4.9/include/linux/mm.h:399: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:400: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:416: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:417: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:438: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:439: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h: In function `pmd_alloc':
/b2/sw/linux-2.4.9/include/linux/mm.h:455: warning: implicit 
declaration of function `__pmd_alloc' 
/b2/sw/linux-2.4.9/include/linux/mm.h:455: warning: return makes 
pointer from integer without a cast
In file included from /b2/sw/linux-2.4.9/include/linux/highmem.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/pagemap.h:16,
                 from /b2/sw/linux-2.4.9/include/linux/locks.h:8,
                 from 
/b2/sw/linux-2.4.9/include/linux/devfs_fs_kernel.h:6,
                 from init/main.c:16:
/b2/sw/linux-2.4.9/include/asm/pgalloc.h: In function `get_pgd_slow':
/b2/sw/linux-2.4.9/include/asm/pgalloc.h:53: warning: implicit 
declaration of function `__get_free_pages'
/b2/sw/linux-2.4.9/include/asm/pgalloc.h: In function `free_pgd_slow':
/b2/sw/linux-2.4.9/include/asm/pgalloc.h:93: warning: implicit 
declaration of function `free_pages'In file included from 
/b2/sw/linux-2.4.9/include/linux/irq.h:57,
                 from /b2/sw/linux-2.4.9/include/asm/hardirq.h:6,
                 from /b2/sw/linux-2.4.9/include/linux/interrupt.h:45,
                 from 
/b2/sw/linux-2.4.9/include/linux/netdevice.h:424,
                 from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/asm/hw_irq.h: At top level:
/b2/sw/linux-2.4.9/include/asm/hw_irq.h:78: parse error before `('
In file included from 
/b2/sw/linux-2.4.9/include/linux/netdevice.h:424,
                 from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/interrupt.h:77: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h:78: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h:154: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h: In function 
`tasklet_schedule':
/b2/sw/linux-2.4.9/include/linux/interrupt.h:159: warning: implicit 
declaration of function `__tasklet_schedule'
/b2/sw/linux-2.4.9/include/linux/interrupt.h: At top level:
/b2/sw/linux-2.4.9/include/linux/interrupt.h:162: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h: In function 
`tasklet_hi_schedule':
/b2/sw/linux-2.4.9/include/linux/interrupt.h:167: warning: implicit 
declaration of function `__tasklet_hi_schedule'
In file included from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/netdevice.h: In function 
`__netif_schedule':
/b2/sw/linux-2.4.9/include/linux/netdevice.h:489: warning: implicit 
declaration of function `cpu_raise_softirq'
In file included from /b2/sw/linux-2.4.9/include/net/ip.h:39,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/net/sock.h: In function `sock_rcvlowat':
/b2/sw/linux-2.4.9/include/net/sock.h:1248: warning: implicit 
declaration of function `min'
/b2/sw/linux-2.4.9/include/net/sock.h:1248: parse error before `int'
/b2/sw/linux-2.4.9/include/net/sock.h:1249: warning: control reaches 
end of non-void function
/b2/sw/linux-2.4.9/include/net/sock.h: In function `sock_intr_errno':
/b2/sw/linux-2.4.9/include/net/sock.h:1256: `LONG_MAX' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/net/sock.h:1256: (Each undeclared 
identifier is reported only once
/b2/sw/linux-2.4.9/include/net/sock.h:1256: for each function it 
appears in.)
/b2/sw/linux-2.4.9/include/net/sock.h:1257: warning: control reaches 
end of non-void function
In file included from /b2/sw/linux-2.4.9/include/linux/raid/md.h:39,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/completion.h: At top level:
/b2/sw/linux-2.4.9/include/linux/completion.h:30: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/completion.h:31: parse error before 
`('
In file included from /b2/sw/linux-2.4.9/include/linux/raid/md.h:51,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/raid/md_k.h: In function 
`pers_to_level':
/b2/sw/linux-2.4.9/include/linux/raid/md_k.h:38: warning: implicit 
declaration of function `panic'
In file included from init/main.c:33:
/b2/sw/linux-2.4.9/include/asm/bugs.h: In function `check_fpu':
/b2/sw/linux-2.4.9/include/asm/bugs.h:71: `KERN_EMERG' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:71: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:72: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:87: `KERN_INFO' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:87: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:92: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h: In function `check_hlt':
/b2/sw/linux-2.4.9/include/asm/bugs.h:115: `KERN_INFO' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:115: parse error before string 
constant
init/main.c: In function `profile_setup':
init/main.c:138: warning: implicit declaration of function 
`get_option'
init/main.c: In function `name_to_kdev_t':
init/main.c:285: warning: implicit declaration of function 
`simple_strtoul'
init/main.c: In function `debug_kernel':
init/main.c:393: `console_loglevel' undeclared (first use in this 
function)
init/main.c: In function `quiet_kernel':
init/main.c:401: `console_loglevel' undeclared (first use in this 
function)
make: *** [init/main.o] Error 1

__________________________________________________________ 
On Saturday 18 August 2001 12:57 pm, Fred Jackson wrote:
> Hi ya,
> 
> I have a Redhat 7.1 system practically out of the box, and though I 
> had no problem compiling 2.4.9 the first time around, I can't 
> recompile it at all without deleting the directory and untaring the 
> distribution again. 
> 
> any ideas?
> 
> thanks in advance!
> 
> Fred
> 
> I start with the usual 
> make mrproper
> make xconfig ( I load a kernel config file - originally created 
with 
> 2.4.8) 
> make bzImage
> make modules
> make modules_install
> make install
> 
> (i've already edited lilo.conf and the links in the /boot directory)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
