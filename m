Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSD1D7B>; Sat, 27 Apr 2002 23:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314675AbSD1D7A>; Sat, 27 Apr 2002 23:59:00 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:12473 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314674AbSD1D65>; Sat, 27 Apr 2002 23:58:57 -0400
Message-ID: <3CCB72E5.1020806@didntduck.org>
Date: Sat, 27 Apr 2002 23:56:21 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Removing SYMBOL_NAME part 2
Content-Type: multipart/mixed;
 boundary="------------040904040502040904050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904040502040904050506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

CRIS and x86-64 arches

-- 

						Brian Gerst

--------------040904040502040904050506
Content-Type: text/plain;
 name="symbol_name-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-2"

diff -urN linux-bg1/arch/cris/kernel/entry.S linux/arch/cris/kernel/entry.S
--- linux-bg1/arch/cris/kernel/entry.S	Thu Mar  7 21:18:27 2002
+++ linux/arch/cris/kernel/entry.S	Sat Apr 27 23:38:47 2002
@@ -789,233 +789,233 @@
 
 	.section .rodata,"a"
 sys_call_table:	
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 0  -  old "setup()" system call*/
-	.long SYMBOL_NAME(sys_exit)
-	.long SYMBOL_NAME(sys_fork)
-	.long SYMBOL_NAME(sys_read)
-	.long SYMBOL_NAME(sys_write)
-	.long SYMBOL_NAME(sys_open)		/* 5 */
-	.long SYMBOL_NAME(sys_close)
-	.long SYMBOL_NAME(sys_waitpid)
-	.long SYMBOL_NAME(sys_creat)
-	.long SYMBOL_NAME(sys_link)
-	.long SYMBOL_NAME(sys_unlink)		/* 10 */
-	.long SYMBOL_NAME(sys_execve)
-	.long SYMBOL_NAME(sys_chdir)
-	.long SYMBOL_NAME(sys_time)
-	.long SYMBOL_NAME(sys_mknod)
-	.long SYMBOL_NAME(sys_chmod)		/* 15 */
-	.long SYMBOL_NAME(sys_lchown16)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old break syscall holder */
-	.long SYMBOL_NAME(sys_stat)
-	.long SYMBOL_NAME(sys_lseek)
-	.long SYMBOL_NAME(sys_getpid)		/* 20 */
-	.long SYMBOL_NAME(sys_mount)
-	.long SYMBOL_NAME(sys_oldumount)
-	.long SYMBOL_NAME(sys_setuid16)
-	.long SYMBOL_NAME(sys_getuid16)
-	.long SYMBOL_NAME(sys_stime)		/* 25 */
-	.long SYMBOL_NAME(sys_ptrace)
-	.long SYMBOL_NAME(sys_alarm)
-	.long SYMBOL_NAME(sys_fstat)
-	.long SYMBOL_NAME(sys_pause)
-	.long SYMBOL_NAME(sys_utime)		/* 30 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old stty syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old gtty syscall holder */
-	.long SYMBOL_NAME(sys_access)
-	.long SYMBOL_NAME(sys_nice)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 35  old ftime syscall holder */
-	.long SYMBOL_NAME(sys_sync)
-	.long SYMBOL_NAME(sys_kill)
-	.long SYMBOL_NAME(sys_rename)
-	.long SYMBOL_NAME(sys_mkdir)
-	.long SYMBOL_NAME(sys_rmdir)		/* 40 */
-	.long SYMBOL_NAME(sys_dup)
-	.long SYMBOL_NAME(sys_pipe)
-	.long SYMBOL_NAME(sys_times)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old prof syscall holder */
-	.long SYMBOL_NAME(sys_brk)		/* 45 */
-	.long SYMBOL_NAME(sys_setgid16)
-	.long SYMBOL_NAME(sys_getgid16)
-	.long SYMBOL_NAME(sys_signal)
-	.long SYMBOL_NAME(sys_geteuid16)
-	.long SYMBOL_NAME(sys_getegid16)	/* 50 */
-	.long SYMBOL_NAME(sys_acct)
-	.long SYMBOL_NAME(sys_umount)		/* recycled never used phys() */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old lock syscall holder */
-	.long SYMBOL_NAME(sys_ioctl)
-	.long SYMBOL_NAME(sys_fcntl)		/* 55 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old mpx syscall holder */
-	.long SYMBOL_NAME(sys_setpgid)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old ulimit syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)       /* old sys_olduname holder */
-	.long SYMBOL_NAME(sys_umask)		/* 60 */
-	.long SYMBOL_NAME(sys_chroot)
-	.long SYMBOL_NAME(sys_ustat)
-	.long SYMBOL_NAME(sys_dup2)
-	.long SYMBOL_NAME(sys_getppid)
-	.long SYMBOL_NAME(sys_getpgrp)		/* 65 */
-	.long SYMBOL_NAME(sys_setsid)
-	.long SYMBOL_NAME(sys_sigaction)
-	.long SYMBOL_NAME(sys_sgetmask)
-	.long SYMBOL_NAME(sys_ssetmask)
-	.long SYMBOL_NAME(sys_setreuid16)	/* 70 */
-	.long SYMBOL_NAME(sys_setregid16)
-	.long SYMBOL_NAME(sys_sigsuspend)
-	.long SYMBOL_NAME(sys_sigpending)
-	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
-	.long SYMBOL_NAME(sys_old_getrlimit)
-	.long SYMBOL_NAME(sys_getrusage)
-	.long SYMBOL_NAME(sys_gettimeofday)
-	.long SYMBOL_NAME(sys_settimeofday)
-	.long SYMBOL_NAME(sys_getgroups16)	/* 80 */
-	.long SYMBOL_NAME(sys_setgroups16)
-	.long SYMBOL_NAME(sys_select)           /* was old_select in Linux/E100 */
-	.long SYMBOL_NAME(sys_symlink)
-	.long SYMBOL_NAME(sys_lstat)
-	.long SYMBOL_NAME(sys_readlink)		/* 85 */
-	.long SYMBOL_NAME(sys_uselib)
-	.long SYMBOL_NAME(sys_swapon)
-	.long SYMBOL_NAME(sys_reboot)
-	.long SYMBOL_NAME(old_readdir)
-	.long SYMBOL_NAME(old_mmap)		/* 90 */
-	.long SYMBOL_NAME(sys_munmap)
-	.long SYMBOL_NAME(sys_truncate)
-	.long SYMBOL_NAME(sys_ftruncate)
-	.long SYMBOL_NAME(sys_fchmod)
-	.long SYMBOL_NAME(sys_fchown16)		/* 95 */
-	.long SYMBOL_NAME(sys_getpriority)
-	.long SYMBOL_NAME(sys_setpriority)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old profil syscall holder */
-	.long SYMBOL_NAME(sys_statfs)
-	.long SYMBOL_NAME(sys_fstatfs)		/* 100 */
-	.long SYMBOL_NAME(sys_ni_syscall)       /* sys_ioperm in i386 */
-	.long SYMBOL_NAME(sys_socketcall)
-	.long SYMBOL_NAME(sys_syslog)
-	.long SYMBOL_NAME(sys_setitimer)
-	.long SYMBOL_NAME(sys_getitimer)	/* 105 */
-	.long SYMBOL_NAME(sys_newstat)
-	.long SYMBOL_NAME(sys_newlstat)
-	.long SYMBOL_NAME(sys_newfstat)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old sys_uname holder */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* sys_iopl in i386 */
-	.long SYMBOL_NAME(sys_vhangup)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old "idle" system call */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* vm86old in i386 */
-	.long SYMBOL_NAME(sys_wait4)
-	.long SYMBOL_NAME(sys_swapoff)		/* 115 */
-	.long SYMBOL_NAME(sys_sysinfo)
-	.long SYMBOL_NAME(sys_ipc)
-	.long SYMBOL_NAME(sys_fsync)
-	.long SYMBOL_NAME(sys_sigreturn)
-	.long SYMBOL_NAME(sys_clone)		/* 120 */
-	.long SYMBOL_NAME(sys_setdomainname)
-	.long SYMBOL_NAME(sys_newuname)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* TODO sys_modify_ldt - do something ?*/
-	.long SYMBOL_NAME(sys_adjtimex)
-	.long SYMBOL_NAME(sys_mprotect)		/* 125 */
-	.long SYMBOL_NAME(sys_sigprocmask)
-	.long SYMBOL_NAME(sys_create_module)
-	.long SYMBOL_NAME(sys_init_module)
-	.long SYMBOL_NAME(sys_delete_module)
-	.long SYMBOL_NAME(sys_get_kernel_syms)	/* 130 */
-	.long SYMBOL_NAME(sys_quotactl)
-	.long SYMBOL_NAME(sys_getpgid)
-	.long SYMBOL_NAME(sys_fchdir)
-	.long SYMBOL_NAME(sys_bdflush)
-	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
-	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
-	.long SYMBOL_NAME(sys_setfsuid16)
-	.long SYMBOL_NAME(sys_setfsgid16)
-	.long SYMBOL_NAME(sys_llseek)		/* 140 */
-	.long SYMBOL_NAME(sys_getdents)
-	.long SYMBOL_NAME(sys_select)
-	.long SYMBOL_NAME(sys_flock)
-	.long SYMBOL_NAME(sys_msync)
-	.long SYMBOL_NAME(sys_readv)		/* 145 */
-	.long SYMBOL_NAME(sys_writev)
-	.long SYMBOL_NAME(sys_getsid)
-	.long SYMBOL_NAME(sys_fdatasync)
-	.long SYMBOL_NAME(sys_sysctl)
-	.long SYMBOL_NAME(sys_mlock)		/* 150 */
-	.long SYMBOL_NAME(sys_munlock)
-	.long SYMBOL_NAME(sys_mlockall)
-	.long SYMBOL_NAME(sys_munlockall)
-	.long SYMBOL_NAME(sys_sched_setparam)
-	.long SYMBOL_NAME(sys_sched_getparam)   /* 155 */
-	.long SYMBOL_NAME(sys_sched_setscheduler)
-	.long SYMBOL_NAME(sys_sched_getscheduler)
-	.long SYMBOL_NAME(sys_sched_yield)
-	.long SYMBOL_NAME(sys_sched_get_priority_max)
-	.long SYMBOL_NAME(sys_sched_get_priority_min)  /* 160 */
-	.long SYMBOL_NAME(sys_sched_rr_get_interval)
-	.long SYMBOL_NAME(sys_nanosleep)
-	.long SYMBOL_NAME(sys_mremap)
-	.long SYMBOL_NAME(sys_setresuid16)
-	.long SYMBOL_NAME(sys_getresuid16)	/* 165 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* sys_vm86 */
-	.long SYMBOL_NAME(sys_query_module)
-	.long SYMBOL_NAME(sys_poll)
-	.long SYMBOL_NAME(sys_nfsservctl)
-	.long SYMBOL_NAME(sys_setresgid16)	/* 170 */
-	.long SYMBOL_NAME(sys_getresgid16)
-	.long SYMBOL_NAME(sys_prctl)
-	.long SYMBOL_NAME(sys_rt_sigreturn)
-	.long SYMBOL_NAME(sys_rt_sigaction)
-	.long SYMBOL_NAME(sys_rt_sigprocmask)	/* 175 */
-	.long SYMBOL_NAME(sys_rt_sigpending)
-	.long SYMBOL_NAME(sys_rt_sigtimedwait)
-	.long SYMBOL_NAME(sys_rt_sigqueueinfo)
-	.long SYMBOL_NAME(sys_rt_sigsuspend)
-	.long SYMBOL_NAME(sys_pread)		/* 180 */
-	.long SYMBOL_NAME(sys_pwrite)
-	.long SYMBOL_NAME(sys_chown16)
-	.long SYMBOL_NAME(sys_getcwd)
-	.long SYMBOL_NAME(sys_capget)
-	.long SYMBOL_NAME(sys_capset)           /* 185 */
-	.long SYMBOL_NAME(sys_sigaltstack)
-	.long SYMBOL_NAME(sys_sendfile)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams1 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams2 */
-	.long SYMBOL_NAME(sys_vfork)            /* 190 */
-	.long SYMBOL_NAME(sys_getrlimit)
-	.long SYMBOL_NAME(sys_mmap2)
-	.long SYMBOL_NAME(sys_truncate64)
-	.long SYMBOL_NAME(sys_ftruncate64)
-	.long SYMBOL_NAME(sys_stat64)		/* 195 */
-	.long SYMBOL_NAME(sys_lstat64)
-	.long SYMBOL_NAME(sys_fstat64)
-	.long SYMBOL_NAME(sys_lchown)
-	.long SYMBOL_NAME(sys_getuid)
-	.long SYMBOL_NAME(sys_getgid)		/* 200 */
-	.long SYMBOL_NAME(sys_geteuid)
-	.long SYMBOL_NAME(sys_getegid)
-	.long SYMBOL_NAME(sys_setreuid)
-	.long SYMBOL_NAME(sys_setregid)
-	.long SYMBOL_NAME(sys_getgroups)	/* 205 */
-	.long SYMBOL_NAME(sys_setgroups)
-	.long SYMBOL_NAME(sys_fchown)
-	.long SYMBOL_NAME(sys_setresuid)
-	.long SYMBOL_NAME(sys_getresuid)
-	.long SYMBOL_NAME(sys_setresgid)	/* 210 */
-	.long SYMBOL_NAME(sys_getresgid)
-	.long SYMBOL_NAME(sys_chown)
-	.long SYMBOL_NAME(sys_setuid)
-	.long SYMBOL_NAME(sys_setgid)
-	.long SYMBOL_NAME(sys_setfsuid)		/* 215 */
-	.long SYMBOL_NAME(sys_setfsgid)
-	.long SYMBOL_NAME(sys_pivot_root)
-	.long SYMBOL_NAME(sys_mincore)
-	.long SYMBOL_NAME(sys_madvise)
-	.long SYMBOL_NAME(sys_getdents64)       /* 220 */
-	.long SYMBOL_NAME(sys_fcntl64)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
-        .long SYMBOL_NAME(sys_ni_syscall)       /* Reserved for Security */
-        .long SYMBOL_NAME(sys_gettid)
-        .long SYMBOL_NAME(sys_readahead)        /* 225 */
-        .long SYMBOL_NAME(sys_tkill)
+	.long sys_ni_syscall	/* 0  -  old "setup()" system call*/
+	.long sys_exit
+	.long sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open		/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink	/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod		/* 15 */
+	.long sys_lchown16
+	.long sys_ni_syscall	/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid	/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_stime		/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime		/* 30 */
+	.long sys_ni_syscall	/* old stty syscall holder */
+	.long sys_ni_syscall	/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall	/* 35  old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir		/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall	/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount	/* recycled never used phys() */
+	.long sys_ni_syscall	/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall	/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall	/* old ulimit syscall holder */
+	.long sys_ni_syscall	/* old sys_olduname holder */
+	.long sys_umask		/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp	/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_sgetmask
+	.long sys_ssetmask
+	.long sys_setreuid16	/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit	/* 75 */
+	.long sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16	/* 80 */
+	.long sys_setgroups16
+	.long sys_select	/* was old_select in Linux/E100 */
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink	/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long old_readdir
+	.long old_mmap		/* 90 */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16	/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall	/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs	/* 100 */
+	.long sys_ni_syscall	/* sys_ioperm in i386 */
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_ni_syscall	/* old sys_uname holder */
+	.long sys_ni_syscall	/* sys_iopl in i386 */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* old "idle" system call */
+	.long sys_ni_syscall	/* vm86old in i386 */
+	.long sys_wait4
+	.long sys_swapoff	/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_ni_syscall	/* TODO sys_modify_ldt - do something ?*/
+	.long sys_adjtimex
+	.long sys_mprotect	/* 125 */
+	.long sys_sigprocmask
+	.long sys_create_module
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_get_kernel_syms	/* 130 */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs		/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall	/* for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek	/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long sys_msync
+	.long sys_readv		/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long sys_mlock		/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
+	.long sys_sched_setparam
+	.long sys_sched_getparam   /* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long sys_mremap
+	.long sys_setresuid16
+	.long sys_getresuid16	/* 165 */
+	.long sys_ni_syscall	/* sys_vm86 */
+	.long sys_query_module
+	.long sys_poll
+	.long sys_nfsservctl
+	.long sys_setresgid16	/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread		/* 180 */
+	.long sys_pwrite
+	.long sys_chown16
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset	/* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall	/* streams1 */
+	.long sys_ni_syscall	/* streams2 */
+	.long sys_vfork		/* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64	/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_lchown
+	.long sys_getuid
+	.long sys_getgid	/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups	/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid	/* 210 */
+	.long sys_getresgid
+	.long sys_chown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid	/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_getdents64	/* 220 */
+	.long sys_fcntl64
+	.long sys_ni_syscall	/* reserved for TUX */
+	.long sys_ni_syscall	/* Reserved for Security */
+	.long sys_gettid
+	.long sys_readahead	/* 225 */
+	.long sys_tkill
 
         /*
          * NOTE!! This doesn't have to be exact - we just have
@@ -1025,6 +1025,6 @@
          */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
-		.long SYMBOL_NAME(sys_ni_syscall)
+		.long sys_ni_syscall
 	.endr
 	
diff -urN linux-bg1/arch/x86_64/boot/compressed/head.S linux/arch/x86_64/boot/compressed/head.S
--- linux-bg1/arch/x86_64/boot/compressed/head.S	Thu Mar  7 21:18:58 2002
+++ linux/arch/x86_64/boot/compressed/head.S	Sat Apr 27 23:19:54 2002
@@ -41,7 +41,7 @@
 	movl %eax,%fs
 	movl %eax,%gs
 
-	lss SYMBOL_NAME(stack_start),%esp
+	lss stack_start,%esp
 	xorl %eax,%eax
 1:	incl %eax		# check that A20 really IS enabled
 	movl %eax,0x000000	# loop forever if it isn't
@@ -59,8 +59,8 @@
  * Clear BSS
  */
 	xorl %eax,%eax
-	movl $ SYMBOL_NAME(_edata),%edi
-	movl $ SYMBOL_NAME(_end),%ecx
+	movl $_edata,%edi
+	movl $_end,%ecx
 	subl %edi,%ecx
 	cld
 	rep
@@ -72,7 +72,7 @@
 	movl %esp,%eax
 	pushl %esi	# real mode pointer as second arg
 	pushl %eax	# address of structure as first arg
-	call SYMBOL_NAME(decompress_kernel)
+	call decompress_kernel
 	orl  %eax,%eax 
 	jnz  3f
 	addl $8,%esp
diff -urN linux-bg1/arch/x86_64/kernel/head.S linux/arch/x86_64/kernel/head.S
--- linux-bg1/arch/x86_64/kernel/head.S	Mon Apr 22 19:17:22 2002
+++ linux/arch/x86_64/kernel/head.S	Sat Apr 27 23:19:54 2002
@@ -305,14 +305,14 @@
 .org 0xb000
 .data
 
-.globl SYMBOL_NAME(gdt)
+.globl gdt
 
 	.word 0
 	.align 16
 	.word 0
 pGDT64:
 	.word	gdt_end-gdt_table
-SYMBOL_NAME_LABEL(gdt)
+gdt:
 	.quad	gdt_table
 	
 

--------------040904040502040904050506--

