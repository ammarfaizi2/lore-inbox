Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbREESvc>; Sat, 5 May 2001 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbREESvV>; Sat, 5 May 2001 14:51:21 -0400
Received: from alfa.intrak.tuke.sk ([147.232.152.3]:50442 "HELO
	alfa.intrak.tuke.sk") by vger.kernel.org with SMTP
	id <S135248AbREESvM>; Sat, 5 May 2001 14:51:12 -0400
Date: Sat, 5 May 2001 22:43:35 +0200
To: linux-kernel@vger.kernel.org
Cc: linux-nvidia@lists.surfsouth.com
Subject: oops
Message-ID: <20010505224335.A1185@etele>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Bial Attila <bial@hron.fei.tuke.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Oops after booting, when wdm starts - attached the_oops.txt and 
output of ksymoops < the_oops.txt

bye
 Ati


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="the_oops.txt"

May  5 20:08:09 etele kernel: NVRM: loading NVIDIA kernel module version 1.0-767
May  5 20:08:11 etele kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
May  5 20:08:11 etele kernel: agpgart: Maximum main memory to use for agp memory: 62M
May  5 20:08:11 etele kernel: agpgart: Detected Ali M1541 chipset
May  5 20:08:11 etele kernel: agpgart: AGP aperture is 32M @ 0xe0000000
May  5 20:08:11 etele kernel: NVRM: AGPGART: ALi M1541 chipset
May  5 20:08:11 etele kernel: NVRM: AGPGART: aperture: 32M @ 0xe0000000
May  5 20:08:11 etele kernel: NVRM: AGPGART: aperture mapped from 0xe0000000 to 0xcb953000
May  5 20:08:11 etele kernel: NVRM: AGPGART: mode 2x
May  5 20:08:11 etele kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May  5 20:08:11 etele kernel:  printing eip:
May  5 20:08:11 etele kernel: c68670b8
May  5 20:08:11 etele kernel: *pde = 00000000
May  5 20:08:11 etele kernel: Oops: 0000
May  5 20:08:11 etele kernel: CPU:    0
May  5 20:08:11 etele kernel: EIP:    0010:[<c68670b8>]
May  5 20:08:11 etele kernel: EFLAGS: 00013056
May  5 20:08:11 etele kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c5bb1ca4
May  5 20:08:11 etele kernel: esi: 00000010   edi: 00000000   ebp: c1337bd8   esp: c1337bc4
May  5 20:08:11 etele kernel: ds: 0018   es: 0018   ss: 0018
May  5 20:08:11 etele kernel: Process XFree86 (pid: 238, stackpage=c1337000)
May  5 20:08:11 etele kernel: Stack: 00000000 00000010 cb8fc004 00002000 00000000 c1337c00 c686745b cb8fc004 
May  5 20:08:11 etele kernel:        00000010 c1337bf8 ffffffff c68e04e0 c5bb1e00 0f000102 c5bb1ca4 c1337c2c 
May  5 20:08:11 etele kernel:        c685f510 cb8fc004 c1337e60 00000010 00000041 c1337c9c 00000002 00002100 
May  5 20:08:11 etele kernel: Call Trace: [<cb8fc004>] [<c686745b>] [<cb8fc004>] [<c68e04e0>] [<c685f510>] [<cb8fc004>] [<c68e0440>] 
May  5 20:08:11 etele kernel:        [<c686386b>] [<cb8fc004>] [<c6863620>] [<cb8fc004>] [<cb8fc004>] [<c6860ad4>] [<cb8fc004>] [timer_interrupt+130/236] 
May  5 20:08:11 etele kernel:        [do_softirq+64/100] [do_IRQ+162/176] [<cb8fc004>] [<c687c1e5>] [<cb8fc004>] [<cb8fc004>] [<cb8fd11c>] [<cb8fd11c>] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [<cb8fd199>] [<cb8fd199>] [<e0000000>] [<cb8fc004>] [<c685e1f5>] [<c68875e6>] [<cb8fc2bc>] 
May  5 20:08:11 etele kernel:        [<cb901094>] [<c68892ac>] [<cb8fc004>] [<cb8fc2bc>] [<c6888996>] [<cb8fc004>] [<cb8fc2bc>] [<cb8fc468>] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [<c689f0e8>] [<cb8fc004>] [<cb8fc004>] [do_page_fault+0/1068] [<cb8fc170>] [<cb8fc004>] [<c689e56b>] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [__alloc_pages+277/672] [__alloc_pages_limit+138/172] [__alloc_pages+277/672] [<cd954040>] [<cd954004>] [__get_free_pages+20/32] [<c685c6be>] 
May  5 20:08:11 etele kernel:        [<c68e04e0>] [<c68e04e0>] [<c685da27>] [<c68e04e0>] [<cd954004>] [<c685de39>] [<c68e04e0>] [do_mmap_pgoff+855/1036] 
May  5 20:08:11 etele kernel:        [old_mmap+234/288] [old_mmap+274/288] [sys_ioctl+362/388] [system_call+51/64] 
May  5 20:08:11 etele kernel: 
May  5 20:08:11 etele kernel: Code: 80 3c 38 00 75 08 83 c3 07 e9 8a 00 00 00 89 d8 c1 e8 03 8b 
May  5 20:08:12 etele kernel: NVRM: AGPGART: backend in use

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Description: ksymoops < the_oops.txt
Content-Disposition: attachment; filename="ksymoops.txt"

ksymoops 2.4.1 on i586 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map-2.4.4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May  5 20:08:11 etele kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May  5 20:08:11 etele kernel: c68670b8
May  5 20:08:11 etele kernel: *pde = 00000000
May  5 20:08:11 etele kernel: Oops: 0000
May  5 20:08:11 etele kernel: CPU:    0
May  5 20:08:11 etele kernel: EIP:    0010:[<c68670b8>]
Using defaults from ksymoops -t elf32-i386 -a i386
May  5 20:08:11 etele kernel: EFLAGS: 00013056
May  5 20:08:11 etele kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c5bb1ca4
May  5 20:08:11 etele kernel: esi: 00000010   edi: 00000000   ebp: c1337bd8   esp: c1337bc4
May  5 20:08:11 etele kernel: ds: 0018   es: 0018   ss: 0018
May  5 20:08:11 etele kernel: Process XFree86 (pid: 238, stackpage=c1337000)
May  5 20:08:11 etele kernel: Stack: 00000000 00000010 cb8fc004 00002000 00000000 c1337c00 c686745b cb8fc004 
May  5 20:08:11 etele kernel:        00000010 c1337bf8 ffffffff c68e04e0 c5bb1e00 0f000102 c5bb1ca4 c1337c2c 
May  5 20:08:11 etele kernel:        c685f510 cb8fc004 c1337e60 00000010 00000041 c1337c9c 00000002 00002100 
May  5 20:08:11 etele kernel: Call Trace: [<cb8fc004>] [<c686745b>] [<cb8fc004>] [<c68e04e0>] [<c685f510>] [<cb8fc004>] [<c68e0440>] 
May  5 20:08:11 etele kernel:        [<c686386b>] [<cb8fc004>] [<c6863620>] [<cb8fc004>] [<cb8fc004>] [<c6860ad4>] [<cb8fc004>] [timer_interrupt+130/236] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [<cb8fd199>] [<cb8fd199>] [<e0000000>] [<cb8fc004>] [<c685e1f5>] [<c68875e6>] [<cb8fc2bc>] 
May  5 20:08:11 etele kernel:        [<cb901094>] [<c68892ac>] [<cb8fc004>] [<cb8fc2bc>] [<c6888996>] [<cb8fc004>] [<cb8fc2bc>] [<cb8fc468>] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [<c689f0e8>] [<cb8fc004>] [<cb8fc004>] [do_page_fault+0/1068] [<cb8fc170>] [<cb8fc004>] [<c689e56b>] 
May  5 20:08:11 etele kernel:        [<cb8fc004>] [__alloc_pages+277/672] [__alloc_pages_limit+138/172] [__alloc_pages+277/672] [<cd954040>] [<cd954004>] [__get_free_pages+20/32] [<c685c6be>] 
May  5 20:08:11 etele kernel:        [<c68e04e0>] [<c68e04e0>] [<c685da27>] [<c68e04e0>] [<cd954004>] [<c685de39>] [<c68e04e0>] [do_mmap_pgoff+855/1036] 
May  5 20:08:11 etele kernel: Code: 80 3c 38 00 75 08 83 c3 07 e9 8a 00 00 00 89 d8 c1 e8 03 8b 

>>EIP; c68670b8 <[NVdriver]nvagp_AllocAGPBitmap+38/e8>   <=====
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c686745b <[NVdriver]NvAllocAGPPages+7b/f8>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c68e04e0 <[NVdriver]TimeStart.22+200/1139f>
Trace; c685f510 <[NVdriver]_nv_rmsym_01382+a4/cc>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c68e0440 <[NVdriver]TimeStart.22+160/1139f>
Trace; c686386b <[NVdriver]_nv_rmsym_00514+103/118>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c6863620 <[NVdriver]_nv_rmsym_00512+80/1c8>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c6860ad4 <[NVdriver]nvExtEscape+3b0/c1c>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fd199 <[NVdriver].bss.end+500bb1a/504e9e1>
Trace; cb8fd199 <[NVdriver].bss.end+500bb1a/504e9e1>
Trace; e0000000 <END_OF_CODE+146bcb01/????>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c685e1f5 <[NVdriver]osAllocMem+e9/11c>
Trace; c68875e6 <[NVdriver]_nv_rmsym_01268+2e/30>
Trace; cb8fc2bc <[NVdriver].bss.end+500ac3d/504e9e1>
Trace; cb901094 <[NVdriver].bss.end+500fa15/504e9e1>
Trace; c68892ac <[NVdriver]heapFbSetAllocParameters+28/2c>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc2bc <[NVdriver].bss.end+500ac3d/504e9e1>
Trace; c6888996 <[NVdriver]_nv_rmsym_01121+846/878>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc2bc <[NVdriver].bss.end+500ac3d/504e9e1>
Trace; cb8fc468 <[NVdriver].bss.end+500ade9/504e9e1>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c689f0e8 <[NVdriver]_nv_rmsym_01280+39c/3c0>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; cb8fc004 <[NVdriver].bss.end+500a985/504e9e1>
Trace; c68e04e0 <[NVdriver]TimeStart.22+200/1139f>
Trace; c68e04e0 <[NVdriver]TimeStart.22+200/1139f>
Trace; c685da27 <[NVdriver]nv_mmap+243/28c>
Trace; c68e04e0 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd954004 <END_OF_CODE+2010b05/????>
Trace; c685de39 <[NVdriver]nv_ioctl+251/270>
Trace; c68e04e0 <[NVdriver]TimeStart.22+200/1139f>
Code;  c68670b8 <[NVdriver]nvagp_AllocAGPBitmap+38/e8>
00000000 <_EIP>:
Code;  c68670b8 <[NVdriver]nvagp_AllocAGPBitmap+38/e8>   <=====
   0:   80 3c 38 00               cmpb   $0x0,(%eax,%edi,1)   <=====
Code;  c68670bc <[NVdriver]nvagp_AllocAGPBitmap+3c/e8>
   4:   75 08                     jne    e <_EIP+0xe> c68670c6 <[NVdriver]nvagp_AllocAGPBitmap+46/e8>
Code;  c68670be <[NVdriver]nvagp_AllocAGPBitmap+3e/e8>
   6:   83 c3 07                  add    $0x7,%ebx
Code;  c68670c1 <[NVdriver]nvagp_AllocAGPBitmap+41/e8>
   9:   e9 8a 00 00 00            jmp    98 <_EIP+0x98> c6867150 <[NVdriver]nvagp_AllocAGPBitmap+d0/e8>
Code;  c68670c6 <[NVdriver]nvagp_AllocAGPBitmap+46/e8>
   e:   89 d8                     mov    %ebx,%eax
Code;  c68670c8 <[NVdriver]nvagp_AllocAGPBitmap+48/e8>
  10:   c1 e8 03                  shr    $0x3,%eax
Code;  c68670cb <[NVdriver]nvagp_AllocAGPBitmap+4b/e8>
  13:   8b 00                     mov    (%eax),%eax


2 warnings issued.  Results may not be reliable.

--a8Wt8u1KmwUX3Y2C--
