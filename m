Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHHSWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHHSWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUHHSWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:22:36 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:48618 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266096AbUHHSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:22:35 -0400
Date: Sun, 8 Aug 2004 14:26:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <je4qndlsho.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0408081423461.19619@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
 <Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072220490.1793@ppc970.osdl.org>
 <Pine.LNX.4.58.0408080143230.19619@montezuma.fsmlabs.com> <je4qndlsho.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Andreas Schwab wrote:

> Zwane Mwaikambo <zwane@linuxpower.ca> writes:
>
> > Index: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> > ===================================================================
> > RCS file: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> > diff -N linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> > --- /dev/null	1 Jan 1970 00:00:00 -0000
> > +++ linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c	8 Aug 2004 05:39:13 -0000
>
> Why not just make this an assembler source?  It contains no real C code.
> The only downside is that EXPORT_SYMBOL must be moved elsewhere, but on
> the other hand it would make the assembler code more readable,

I thought about doing that, but this version touched the least amount of
files.
