Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269430AbUJSOmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269430AbUJSOmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUJSOmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:42:49 -0400
Received: from lucidpixels.com ([66.45.37.187]:39555 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S269429AbUJSOme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:42:34 -0400
Date: Tue, 19 Oct 2004 10:42:31 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: nvidia@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 breaks NVidia module, cannot start X.
Message-ID: <Pine.LNX.4.61.0410191040270.8554@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6.9
GCC: 3.4.2
NVIDIA: 6111 (latest as of 10/19/04)

   cc 
-Wp,-MD,/appc/kernel/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/.nvidia.mod.
o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall 
-Wstrict-protot
ypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 
-fomit-frame-pointer -W
declaration-after-statement -pipe -msoft-float 
-mpreferred-stack-boundary=2 -fno
-unit-at-a-time -march=pentium4 -Iinclude/asm-i386/mach-default 
-DKBUILD_BASE
NAME=nvidia -DKBUILD_MODNAME=nvidia -DMODULE -c -o 
/appc/kernel/NVIDIA-Linux-x86
-1.0-6111-pkg1/usr/src/nv/nvidia.mod.o 
/appc/kernel/NVIDIA-Linux-x86-1.0-6111-pk
g1/usr/src/nv/nvidia.mod.c
   ld -m elf_i386 -r -o 
/appc/kernel/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv
idia.ko /appc/kernel/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nvidia.o 
/appc/ke
rnel/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nvidia.mod.o
make[1]: Leaving directory `/usr/src/linux-2.6.9'
NVIDIA: left KBUILD.
FATAL: Error inserting nvidia 
(/lib/modules/2.6.9/kernel/drivers/video/nvidia.ko
): Unknown symbol in module, or unknown parameter (see dmesg)
make: *** [package-install] Error 1

# dmesg
nvidia: module license 'NVIDIA' taints kernel.
nvidia: Unknown symbol __VMALLOC_RESERVE
nvidia: Unknown symbol __VMALLOC_RESERVE

