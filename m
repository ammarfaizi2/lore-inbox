Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSF0Ghl>; Thu, 27 Jun 2002 02:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSF0Ghk>; Thu, 27 Jun 2002 02:37:40 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:6063 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S316608AbSF0Ghk>;
	Thu, 27 Jun 2002 02:37:40 -0400
Date: Thu, 27 Jun 2002 08:35:05 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Robert Love <rml@tech9.net>
cc: Dan Sturtevant <dsturtev@plogic.com>, <linux-kernel@vger.kernel.org>
Subject: Re: x86 Page Sizes
In-Reply-To: <1025129491.1144.7.camel@icbm>
Message-ID: <Pine.LNX.4.44.0206270832400.1602-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2002, Robert Love wrote:

> Kernel has 4K pages in user and kernel space.  It is the same address
> space and segment, just uses MMU protection.
> 
> x86 does 4K pages.

The x86 cpus can use 4K or 4M pages in the hardware. The 4M pages are 
restricted to the kernel in Linux due to various problems. This has been 
discussed on this list a while ago. The thread was called "Have the 2.4 
kernel memory management problems on large machines been fixed?" the last 
time around.

4M pages are useful to minimize tlb misses which can be costly for some 
algorithms.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


