Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264990AbUD2WI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbUD2WI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUD2WI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:08:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13288 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S264990AbUD2WIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:08:51 -0400
Date: Thu, 29 Apr 2004 15:08:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (ppc)
Message-ID: <20040429220848.GA3731@smtp.west.cox.net>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiw-00056A-Qw@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BFYiw-00056A-Qw@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 02:22:10PM +0100, Russell King wrote:

> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/ppc/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.
> 
> Please ensure that at least the first two patches have already
> been applied to your tree; they can be found at:
> 
> 	http://lkml.org/lkml/2004/4/18/86
> 	http://lkml.org/lkml/2004/4/18/87
> 
> This patch is part of a larger patch aiming towards getting the
> include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
> can sanely get at things like mm_struct and friends.
> 
> In the event that any of these files fails to build, chances are
> you need to include some other header file rather than pgalloc.h.
> Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
> or asm/tlbflush.h.

Better late than never I hope, this is fine on ppc32.

-- 
Tom Rini
http://gate.crashing.org/~trini/
