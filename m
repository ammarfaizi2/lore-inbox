Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTICQsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTICQr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:47:26 -0400
Received: from alfarrabio.di.uminho.pt ([193.136.20.210]:54487 "HELO
	alfarrabio.di.uminho.pt") by vger.kernel.org with SMTP
	id S264069AbTICQqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:46:09 -0400
Subject: Re: Problems compiling kernel 2.4.22
From: Alberto Manuel =?ISO-8859-1?Q?Brand=E3o_Sim=F5es?= 
	<albie@alfarrabio.di.uminho.pt>
Reply-To: albie@alfarrabio.di.uminho.pt
To: linux-kernel@vger.kernel.org
In-Reply-To: <1062606509.623.20.camel@eremita.di.uminho.pt>
References: <1062606509.623.20.camel@eremita.di.uminho.pt>
Content-Type: text/plain; charset=iso-8859-15
Organization: Departamento de  =?ISO-8859-1?Q?=20Inform=C3=A1tica?= - Universidade do Minho
Message-Id: <1062607884.623.23.camel@eremita.di.uminho.pt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 03 Sep 2003 17:51:24 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 17:28, Alberto Manuel Brandão Simões wrote:
> [1.] One line summary of the problem:    
>  modules symbols broken references
> 
> [2.] Full description of the problem/report:
>  when I make 'make modules_install' I get:
>  depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipv4/ipip.o
>  depmod:         ip_send_check
>  depmod:         register_netdevice
>  ..
> 
> and so on, and not only for these modules: vfat, smbfs, msdos, etc
> 
> By the way, when I tried to ssh to paste more information, I got in the 
> console:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000fc
> *pde = 0000000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[c019fb66>]    Not tainted
> EFLAGS: 00010286
> eax: 00000000  ebx: ffffff4  ecx: cf7e83c8  edx: ca2631e0
> ...
> and more I can't paste... to copy hex code is too hawful!
OK. Recompiled the kernel and know I can ssh to it....
Still with the same problem with undefined references.

Have too a problem with ACPI. I can't modprobe any of the ACPI modules
(init_module: No such device). And yes, I don't have the /proc/acpi
directory.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
>  modules, kernel
> 
> [4.] Kernel version (from /proc/version):
>  2.4.22
> 
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
>  Gnu C - 2.95.3
>  Gnu make - 3.79.1
>  util-linux - 2.11f
>  mount - 2.11b
>  modutils - 2.4.6
>  e2fsprogs - 1.25
>  reiserfsprogs - 3.x.0j
>  pcmcia-cs - 3.2.3
>  PPP - 2.4.1
>  Linux C Library - 2.3.2
>  Dynamic linker (ldd) - 2.3.2
>  Linux C++ Library 3.0.2
>  Procps - 2.0.7
>  Net-tools - 1.60
>  Kbd - 1.06
>  Sh-utils - 2.0
>  Modules Loaded: usb-storage, usb-ohci, hid, usbcore, mousedev, input, sr_mod,
> ide-scsi, ide-cd, cdrom, isofs, zlib_inflate, trident, ac97_codec, soundcore,
> sis900, crc32, pcmcia_core, parport_pc, parport, vfat, fat
> 
> [7.2.] Processor information (from /proc/cpuinfo):
>  processor: 0
>  vendor_id: GenuineIntel
>  cpu_family: 6
>  model: 8
>  model name: Pentium III (Coppermine)
>  stepping: 10
>  cpu MHz: 996.837
>  cache size: 256 KB
>  fdiv_bug: no
>  hlt_bug: no
>  f00f_bug: no
>  coma_bug: no
>  fpu: yes
>  fpu_exception: yes
>  cpuid level: 2
>  wp: yes
>  flags: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
>  bogomips: 1985.74
> 
> ...
> 
> Please send any answer with cc to me... I'm not subscribed.

