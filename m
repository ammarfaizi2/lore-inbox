Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbSLNJit>; Sat, 14 Dec 2002 04:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbSLNJit>; Sat, 14 Dec 2002 04:38:49 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:63502 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S267536AbSLNJis>;
	Sat, 14 Dec 2002 04:38:48 -0500
Subject: Re: rmap and nvidia?
From: mdew <mdew@orcon.net.nz>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021214093831.GL9882@holomorphy.com>
References: <1039858571.559.15.camel@nirvana> 
	<20021214093831.GL9882@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Dec 2002 22:46:34 +1300
Message-Id: <1039859196.771.18.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-14 at 22:38, William Lee Irwin III wrote:
> On Sat, Dec 14, 2002 at 10:36:10PM +1300, mdew wrote:
> > is there a nvidia patch available to make it work with rmap?
> > 
> > nirvana:~/NVIDIA_kernel-1.0-3123# make
> > echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -1`\" > nv_compiler.h
> > cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
> > -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
> > -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -DNTRM -D_GNU_SOURCE
> > -DRM_HEAPMGR -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE 
> > -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=3123 
> > -DNV_UNIX   -DNV_LINUX   -DNVCPU_X86       -I.
> > -I/lib/modules/2.4.20-xfs-rmap15b/build/include -Wno-cast-qual nv.c
> > nv.c: In function `nv_get_phys_address':
> > nv.c:2182: warning: implicit declaration of function `pte_offset'
> > nv.c:2182: invalid type argument of `unary *'
> > make: *** [nv.o] Error 1
> 
> Use pte_offset_map() with a corresponding pte_unmap().

err pardon?


