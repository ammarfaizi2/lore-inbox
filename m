Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSF0O2X>; Thu, 27 Jun 2002 10:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSF0O2W>; Thu, 27 Jun 2002 10:28:22 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:40336 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S316860AbSF0O2V>; Thu, 27 Jun 2002 10:28:21 -0400
Subject: Re: x86 Page Sizes
From: Steven Cole <elenstev@mesatop.com>
To: Peter Svensson <petersv@psv.nu>
Cc: Robert Love <rml@tech9.net>, Dan Sturtevant <dsturtev@plogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206270832400.1602-100000@cheetah.psv.nu>
References: <Pine.LNX.4.44.0206270832400.1602-100000@cheetah.psv.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 27 Jun 2002 08:26:07 -0600
Message-Id: <1025187969.27133.117.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-27 at 00:35, Peter Svensson wrote:
> On 26 Jun 2002, Robert Love wrote:
> 
> > Kernel has 4K pages in user and kernel space.  It is the same address
> > space and segment, just uses MMU protection.
> > 
> > x86 does 4K pages.
> 
> The x86 cpus can use 4K or 4M pages in the hardware. The 4M pages are 
> restricted to the kernel in Linux due to various problems. This has been 
> discussed on this list a while ago. The thread was called "Have the 2.4 
> kernel memory management problems on large machines been fixed?" the last 
> time around.
> 
> 4M pages are useful to minimize tlb misses which can be costly for some 
> algorithms.
> 
> Peter

In addition to that thread, you might want to read the paper "Multiple
Page Size Support in the Linux Kernel", pages 573-593 in the Proceedings
of the Ottawa Linux Symposium which you can download from here:

http://www.linuxsymposium.org/2002/ 

If you're on a slow connection, be forewarned that it is a 631 page pdf,
but thankfully it's compressed.

Steven


