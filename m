Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRFDTWu>; Mon, 4 Jun 2001 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbRFDTWc>; Mon, 4 Jun 2001 15:22:32 -0400
Received: from web13706.mail.yahoo.com ([216.136.175.139]:50700 "HELO
	web13706.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262058AbRFDTWV>; Mon, 4 Jun 2001 15:22:21 -0400
Message-ID: <20010604192218.31145.qmail@web13706.mail.yahoo.com>
Date: Mon, 4 Jun 2001 12:22:18 -0700 (PDT)
From: jalaja devi <jala_74@yahoo.com>
Subject: RPM Installation - Compilation errors
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20010520235409.G2647@bug.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to install an RPM in Redhat 6.2. But
landed up in getting these compilation errors. Could
anyone tell me watzall this mean.


I did 
rpm --rebuild "x.rpm"

Thanks in advance,
Jalaja


+ umask 022
+ cd /usr/src/redhat/BUILD
+ cd /usr/src/redhat/BUILD
+ rm -rf wnp1-2.0b1
+ /bin/mkdir -p wnp1-2.0b1
+ cd wnp1-2.0b1
+ /bin/gzip -dc
/usr/src/redhat/SOURCES/wnp1-2.0b1.tar.gz
+ tar -xvvf -
+ STATUS=0
+ [ 0 -ne 0 ]
++ /usr/bin/id -u
+ [ 0 = 0 ]
+ /bin/chown -Rhf root .
++ /usr/bin/id -u
+ [ 0 = 0 ]
+ /bin/chgrp -Rhf root .
+ /bin/chmod -Rf a+rX,g-w,o-w .
+ mkdir -p /usr/doc/wnp1-2.0b1
+ cp -f /usr/src/redhat/SOURCES/wnp1-2.0b1.tar.gz
/usr/doc/wnp1-2.0b1
+ exit 0
+ umask 022
+ cd /usr/src/redhat/BUILD
+ cd wnp1-2.0b1
+ cd ./WaveNIC1/Linux/AdapterDriver
+ cpu_count=0
+ find_num_proc
+ v1=processor
+ read proc sep count
+ [ -n processor ]
+ [ processor = processor ]
+ cpu_count=1
+ read proc sep count
+ [ -n vendor_id ]
+ [ vendor_id = processor ]
+ read proc sep count
+ [ -n cpu ]
+ [ cpu = processor ]
+ read proc sep count
+ [ -n model ]
+ [ model = processor ]
+ read proc sep count
+ [ -n model ]
+ [ model = processor ]
+ read proc sep count
+ [ -n stepping ]
+ [ stepping = processor ]
+ read proc sep count
+ [ -n cpu ]
+ [ cpu = processor ]
+ read proc sep count
+ [ -n cache ]
+ [ cache = processor ]
+ read proc sep count
+ [ -n fdiv_bug ]
+ [ fdiv_bug = processor ]
+ read proc sep count
+ [ -n hlt_bug ]
+ [ hlt_bug = processor ]
+ read proc sep count
+ [ -n sep_bug ]
+ [ sep_bug = processor ]
+ read proc sep count
+ [ -n f00f_bug ]
+ [ f00f_bug = processor ]
+ read proc sep count
+ [ -n coma_bug ]
+ [ coma_bug = processor ]
+ read proc sep count
+ [ -n fpu ]
+ [ fpu = processor ]
+ read proc sep count
+ [ -n fpu_exception ]
+ [ fpu_exception = processor ]
+ read proc sep count
+ [ -n cpuid ]
+ [ cpuid = processor ]
+ read proc sep count
+ [ -n wp ]
+ [ wp = processor ]
+ read proc sep count
+ [ -n flags ]
+ [ flags = processor ]
+ read proc sep count
+ [ -n bogomips ]
+ [ bogomips = processor ]
+ read proc sep count
+ [ -n  ]
+ read proc sep count
+ echo cpu_count  1
+ [ 1 -gt 1 ]
+ make
Makefile:137: wnicp1_d.d: No such file or directory
Makefile:137: OsSupport_d.d: No such file or directory
Makefile:137: wnic_proc_d.d: No such file or directory
Makefile:137: wnic_ioctl_d.d: No such file or
directory
Makefile:137: Device_d.d: No such file or directory
Makefile:137: Driver_d.d: No such file or directory
Makefile:137: Data_d.d: No such file or directory
Makefile:137: Enet_d.d: No such file or directory
Makefile:137: Fragment_d.d: No such file or directory
Makefile:137: MI_d.d: No such file or directory
Makefile:137: Mem_d.d: No such file or directory
Makefile:137: OC48_d.d: No such file or directory
Makefile:137: Od_d.d: No such file or directory
Makefile:137: PppSend_d.d: No such file or directory
Makefile:137: PppSupport_d.d: No such file or
directory
Makefile:137: TA1000_d.d: No such file or directory
Makefile:137: pm5357_d.d: No such file or directory
Makefile:137: if_spppsubr_d.d: No such file or
directory
Makefile:137: suni2488_api_d.d: No such file or
directory
Makefile:137: suni2488_hw_d.d: No such file or
directory
Makefile:137: suni2488_intf_d.d: No such file or
directory
Makefile:137: suni2488_isr_d.d: No such file or
directory
Makefile:137: suni2488_loh_d.d: No such file or
directory
Makefile:137: suni2488_poh_d.d: No such file or
directory
Makefile:137: suni2488_pyld_d.d: No such file or
directory
Makefile:137: suni2488_rtos_d.d: No such file or
directory
Makefile:137: suni2488_soh_d.d: No such file or
directory
Makefile:137: suni2488_util_d.d: No such file or
directory
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_util.c:39:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_util.c:39:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_soh.c:38:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_soh.c:38:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_rtos.c:36:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_rtos.c:36:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_pyld.c:38:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_pyld.c:38:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_poh.c:39:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_poh.c:39:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_loh.c:38:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_loh.c:38:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_isr.c:45:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_isr.c:45:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_intf.c:39:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_intf.c:39:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_hw.c:47:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_hw.c:47:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_api.c:46:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/suni2488_rtos.h:39,
                 from
../../SharedSource/suni2488_api.h:47,
                 from
../../SharedSource/suni2488_api.c:46:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/pm5357.c:53:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/pm5357.c:53:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/pm5357.c:56:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/pm5357.c:56:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/TA1000.c:29:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/TA1000.c:29:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/TA1000.c:30:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/TA1000.c:30:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/PppSupport.c:29:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/PppSupport.c:29:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from
../../SharedSource/PppSupport.c:30:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from
../../SharedSource/PppSupport.c:30:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/PppSend.c:25:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/PppSend.c:25:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/PppSend.c:26:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/PppSend.c:26:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from ../../SharedSource/Od.c:25:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from ../../SharedSource/Od.c:25:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/OC48.c:28:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/OC48.c:28:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/OC48.c:29:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/OC48.c:29:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Mem.c:25:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Mem.c:25:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/MI.c:22:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/MI.c:22:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/MI.c:23:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/MI.c:23:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Mem.h:27,
                 from
../../SharedSource/Fragment.c:23:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Mem.h:27,
                 from
../../SharedSource/Fragment.c:23:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Enet.c:22:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Enet.c:22:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/Enet.c:23:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from ../../SharedSource/Enet.c:23:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Data.h:38,
                 from ../../SharedSource/Data.c:25:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from ../../SharedSource/Data.h:38,
                 from ../../SharedSource/Data.c:25:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from ../include/Driver.h:32,
                 from Driver.c:24:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from ../include/Driver.h:32,
                 from Driver.c:24:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from Driver.c:24:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from Driver.c:24:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from Driver.c:35:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from Device.c:25:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from Device.c:25:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from Device.c:38:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from ../include/Driver.h:40,
                 from Device.c:38:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from Device.c:41:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from wnic_ioctl.c:27:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from wnic_ioctl.c:27:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:51,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from
/usr/src/linux/include/net/sock.h:52,
                 from wnic_ioctl.c:43:
/usr/src/linux/include/asm/hardirq.h:23: warning:
`synchronize_irq' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:78:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/interrupt.h:52,
                 from
/usr/src/linux/include/linux/netdevice.h:334,
                 from
/usr/src/linux/include/net/sock.h:52,
                 from wnic_ioctl.c:43:
/usr/src/linux/include/asm/softirq.h:72: warning:
`synchronize_bh' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:80:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from wnic_ioctl.c:47:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from wnic_proc.c:21:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from wnic_proc.c:21:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from wnic_proc.c:34:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from OsSupport.c:22:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from OsSupport.c:22:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from OsSupport.c:23:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from wnicp1.c:38:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from wnicp1.c:38:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from wnicp1.c:45:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
In file included from
/usr/src/linux/include/linux/sched.h:20,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from wnicp1.c:38:
/usr/src/linux/include/linux/smp.h:77: warning:
`smp_num_cpus' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:72:
warning: this is the location of the previous
definition
/usr/src/linux/include/linux/smp.h:83: warning:
`smp_call_function' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:98:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/linux/sched.h:74,
                 from
/usr/src/linux/include/linux/mm.h:4,
                 from
/usr/src/linux/include/linux/slab.h:14,
                 from
/usr/src/linux/include/linux/malloc.h:4,
                 from ../include/Linux.h:38,
                 from
../../include/../Linux/include/OsSupport.h:23,
                 from ../../include/OsEnv.h:179,
                 from
../../SharedSource/KernelOdWrapper.h:29,
                 from wnicp1.c:38:
/usr/src/linux/include/asm/processor.h:175: warning:
`cpu_data' redefined
/usr/src/linux/include/linux/modules-smp/i386_ksyms.ver:62:
warning: this is the location of the previous
definition
In file included from
/usr/src/linux/include/asm/pgtable.h:85,
                 from
/usr/src/linux/include/linux/vmalloc.h:7,
                 from
/usr/src/linux/include/asm/io.h:102,
                 from ../include/wnicp1.h:79,
                 from wnicp1.c:45:
/usr/src/linux/include/asm/smp.h:204: warning:
`smp_processor_id' redefined
/usr/src/linux/include/linux/smp.h:78: warning: this
is the location of the previous definition
/usr/src/linux/include/asm/smp.h:206: arguments given
to macro `hard_smp_processor_id'
make: *** [wnicp1.o] Error 1
Bad exit status from /var/tmp/rpm-tmp.86686 (%build)


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
