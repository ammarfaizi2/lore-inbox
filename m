Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTEPI0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTEPI0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:26:51 -0400
Received: from ns.suse.de ([213.95.15.193]:9480 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264379AbTEPI0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:26:50 -0400
Date: Fri, 16 May 2003 10:39:41 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [x86_64 PATCH] IA32 vsyscall DSO compatibility in IA32_EMULATION
Message-ID: <20030516083941.GA701@Wotan.suse.de>
References: <20030516070813.GA11846@Wotan.suse.de> <200305160830.h4G8Ufx01882@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305160830.h4G8Ufx01882@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 01:30:41AM -0700, Roland McGrath wrote:
> > On Thu, May 15, 2003 at 03:39:36PM -0700, Roland McGrath wrote:
> > > Btw, 2.5 ia32 core dumping on x86-64 as is crashes without the patch I just
> > > posted to lkml.
> > 
> > Check out ftp://ftp.x86-64.org/pub/linux/v2.5/x86_64-2.5.69-4.bz2
> 
> Too bad such changes don't go into the main 2.5 tree quickly enough for me
> to see them when I look.

I submitted them three times so far, but Linus currently prefers to drop
patches instead of merging them.

> 
> My changes reduce the hard-coding of so many address and offset constants,
> and reduce the error-prone duplication and maintenance work by using the
> i386 vsyscall.lds linker script directly.  You might want to incorporate that.

I like my current code, thank you.

-Andi
