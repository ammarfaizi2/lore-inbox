Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJ2SMv>; Tue, 29 Oct 2002 13:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJ2SMv>; Tue, 29 Oct 2002 13:12:51 -0500
Received: from f96.law3.hotmail.com ([209.185.241.96]:20996 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262062AbSJ2SMk>;
	Tue, 29 Oct 2002 13:12:40 -0500
X-Originating-IP: [212.205.251.86]
From: "Ironhell3 ." <ironhell3@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re:SMP problem
Date: Tue, 29 Oct 2002 18:18:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F96lm70rM3TbhyF2fPm0000020a@hotmail.com>
X-OriginalArrivalTime: 29 Oct 2002 18:18:58.0092 (UTC) FILETIME=[A5E59EC0:01C27F77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The build errors i get when i try to compile 2.4.19 or 2.4.20-pre11 without 
SMP support are the following:


In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/ext3_fs_sb.h:20,
                 from /usr/src/linux-2.4.20pre11/include/linux/fs.h:685,
                 from 
/usr/src/linux-2.4.20pre11/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20pre11/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20pre11/include/linux/sched.h:9,
                 from exec_domain.c:16:
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: 
`del_timer_sync' r
edefined
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
this is
the location of the previous definition
In file included from /usr/src/linux-2.4.20pre11/include/linux/sched.h:23,
                 from exec_domain.c:16:
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: `smp_num_cpus' 
redef
ined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
thi
s is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: 
`smp_call_function'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: th
is is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: `cpu_online_map' 
red
efined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
thi
s is the location of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from printk.c:26:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from printk.c:26:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
`sm
p_num_cpus' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
`cp
u_online_map' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: `s
mp_call_function' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: this is the 
location
of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:159
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from printk.c:26:
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
`del_ti
mer_sync' redefined
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: this is the 
locati
on of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/interrupt.h:45,
                 from printk.c:27:
/usr/src/linux-2.4.20pre11/include/asm/hardirq.h:37: warning: 
`synchronize_irq'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:90: warning: 
thi
s is the location of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from signal.c:11:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from signal.c:11:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
`sm
p_num_cpus' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
`cp
u_online_map' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: `s
mp_call_function' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: this is the 
location
of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:159
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from signal.c:11:
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
`del_ti
mer_sync' redefined
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: this is the 
locati
on of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from sys.c:7:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from sys.c:7:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/ext3_fs_sb.h:20,
                 from /usr/src/linux-2.4.20pre11/include/linux/fs.h:685,
                 from 
/usr/src/linux-2.4.20pre11/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20pre11/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20pre11/include/linux/sched.h:9,
                 from /usr/src/linux-2.4.20pre11/include/linux/mm.h:4,
                 from sys.c:8:
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: 
`del_timer_sync' r
edefined
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
this is
the location of the previous definition
In file included from /usr/src/linux-2.4.20pre11/include/linux/sched.h:23,
                 from /usr/src/linux-2.4.20pre11/include/linux/mm.h:4,
                 from sys.c:8:
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: `smp_num_cpus' 
redef
ined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
thi
s is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: 
`smp_call_function'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: th
is is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: `cpu_online_map' 
red
efined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
thi
s is the location of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from kmod.c:22:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from kmod.c:22:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/ext3_fs_sb.h:20,
                 from /usr/src/linux-2.4.20pre11/include/linux/fs.h:685,
                 from 
/usr/src/linux-2.4.20pre11/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20pre11/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20pre11/include/linux/sched.h:9,
                 from kmod.c:23:
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: 
`del_timer_sync' r
edefined
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
this is
the location of the previous definition
In file included from /usr/src/linux-2.4.20pre11/include/linux/sched.h:23,
                 from kmod.c:23:
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: `smp_num_cpus' 
redef
ined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
thi
s is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: 
`smp_call_function'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: th
is is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: `cpu_online_map' 
red
efined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
thi
s is the location of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from context.c:16:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from context.c:16:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/ext3_fs_sb.h:20,
                 from /usr/src/linux-2.4.20pre11/include/linux/fs.h:685,
                 from 
/usr/src/linux-2.4.20pre11/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20pre11/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20pre11/include/linux/sched.h:9,
                 from context.c:18:
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: 
`del_timer_sync' r
edefined
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
this is
the location of the previous definition
In file included from /usr/src/linux-2.4.20pre11/include/linux/sched.h:23,
                 from context.c:18:
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: `smp_num_cpus' 
redef
ined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
thi
s is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: 
`smp_call_function'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: th
is is the location of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: `cpu_online_map' 
red
efined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
thi
s is the location of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:68,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux-2.4.20pre11/include/linux/modules/dec_and_lock.ver:2: 
warning: `a
tomic_dec_and_lock' redefined
/usr/src/linux-2.4.20pre11/include/linux/spinlock.h:65: warning: this is the 
loc
ation of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:130
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:82: warning: 
`cp
u_data' redefined
/usr/src/linux-2.4.20pre11/include/asm/processor.h:80: warning: this is the 
loca
tion of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:86: warning: 
`sm
p_num_cpus' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:80: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:88: warning: 
`cp
u_online_map' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:88: warning: this is the 
location
of the previous definition
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:102: 
warning: `s
mp_call_function' redefined
/usr/src/linux-2.4.20pre11/include/linux/smp.h:87: warning: this is the 
location
of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/modversions.h:159
,
                 from /usr/src/linux-2.4.20pre11/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux-2.4.20pre11/include/linux/modules/ksyms.ver:546: warning: 
`del_ti
mer_sync' redefined
/usr/src/linux-2.4.20pre11/include/linux/timer.h:30: warning: this is the 
locati
on of the previous definition
In file included from 
/usr/src/linux-2.4.20pre11/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/linux-2.4.20pre11/include/asm/hardirq.h:37: warning: 
`synchronize_irq'
redefined
/usr/src/linux-2.4.20pre11/include/linux/modules/i386_ksyms.ver:90: warning: 
thi
s is the location of the previous definition
In file included from ksyms.c:17:
/usr/src/linux-2.4.20pre11/include/linux/kernel_stat.h: In function 
`kstat_irqs'
:
/usr/src/linux-2.4.20pre11/include/linux/kernel_stat.h:57: `smp_num_cpus' 
undecl
ared (first use in this function)
/usr/src/linux-2.4.20pre11/include/linux/kernel_stat.h:57: (Each undeclared 
iden
tifier is reported only once
/usr/src/linux-2.4.20pre11/include/linux/kernel_stat.h:57: for each function 
it
appears in.)
make[2]: *** [ksyms.o] Error 1
make[1]: *** [first_rule] Error 2
make: *** [_dir_kernel] Error 2

the stability issues i have are:
kernel freezes randomly.That means that it freezes when i am on the 
internet,or listening to music,in X and not in X.And i believe that this has 
to do with this SMP problem.I need help here :)
Thanks!


_________________________________________________________________
Unlimited Internet access -- and 2 months free!  Try MSN. 
http://resourcecenter.msn.com/access/plans/2monthsfree.asp

