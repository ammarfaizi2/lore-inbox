Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282856AbRK0IMZ>; Tue, 27 Nov 2001 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282851AbRK0IMM>; Tue, 27 Nov 2001 03:12:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282866AbRK0IL5>;
	Tue, 27 Nov 2001 03:11:57 -0500
Date: Tue, 27 Nov 2001 09:11:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Marco Berizzi <pupilla@hotmail.com>
Cc: chaffee@cs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Message-ID: <20011127091137.Z5129@suse.de>
In-Reply-To: <LAW2-OE64dLLZfOfAD200002cce@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW2-OE64dLLZfOfAD200002cce@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Marco Berizzi wrote:
> I have upgraded my PC from 768MB RAM to 1GB.
> I have recompiled the kernel (2.4.16) for hi mem support (4GB).
> 
> I have several file system on the same disk (vfat file system). I have
> compiled vfat driver both in the main kernel and as a module. When I
> load the module I issue a
> 'modprobe vfat' and I get this message (only with hi mem kernel
> support):
> 
> Warning: loading /lib/modules/2.4.16/kernel/fs/vfat/vfat.o will taint
> the kernel: no license
>  I'm using Slackware 8.0. + modutils 2.4.12
> 
> Then if I try to copy a file from that filesystem to the root filesystem
> I get this error:
> 
> Kernel panic: too few segs for DMA mappings increase AHC_NSEG
> 
> Kernel panic: too few segs for DMA mappings increase AHC_NSEG

You still haven't applied the patch I sent? Sending the same report
without this extra added infor 2 or 3 times isn't doing any good, sorry.

-- 
Jens Axboe

