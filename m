Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319015AbSHSU5Y>; Mon, 19 Aug 2002 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319012AbSHSU5Y>; Mon, 19 Aug 2002 16:57:24 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:41576 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S319015AbSHSU5Y>; Mon, 19 Aug 2002 16:57:24 -0400
Date: Mon, 19 Aug 2002 16:01:14 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <91360000.1029790874@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 19, 2002 10:59:17 PM +0200 Ingo Molnar <mingo@elte.hu>
wrote:

> this whole mess can only be fixed by decoupling the ptrace() mechanism
> from signals and wait4 completely, it's a nasty relationship that infests
> both the kernel and userspace code [check out strace.c once to see the
> kind of pain it has to go through to isolate ptrace events from other
> signals.]

I guess this is why most versions of Unix have abandoned ptrace for a
debugging API based on /proc.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

