Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUDSOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUDSOEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:04:32 -0400
Received: from ns.suse.de ([195.135.220.2]:53740 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264466AbUDSODb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:03:31 -0400
Date: Mon, 19 Apr 2004 16:03:29 +0200
From: Andi Kleen <ak@suse.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] Clean up asm/pgalloc.h include (x86_64)
Message-Id: <20040419160329.7f298db2.ak@suse.de>
In-Reply-To: <E1BFYk0-00056V-M5@dyn-67.arm.linux.org.uk>
References: <20040418231720.C12222@flint.arm.linux.org.uk>
	<20040418232314.A2045@flint.arm.linux.org.uk>
	<E1BFYk0-00056V-M5@dyn-67.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 14:23:16 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/x86_64/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.
> 
> Please ensure that at least the first two patches have already
> been applied to your tree; they can be found at:
> 
> 	http://lkml.org/lkml/2004/4/18/86
> 	http://lkml.org/lkml/2004/4/18/87


Compiles for me as SMP/NUMA and UP.

-Andi
