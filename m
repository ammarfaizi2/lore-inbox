Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUBFPtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 10:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUBFPtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 10:49:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3033
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265526AbUBFPtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 10:49:08 -0500
Date: Fri, 6 Feb 2004 16:49:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040206154906.GS31926@dualathlon.random>
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random> <40235D0B.5090008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40235D0B.5090008@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 01:23:23AM -0800, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrea Arcangeli wrote:
> 
> > I don't think I was arguing against it completely, exactly because I'm
> > just saying it should be optional.
> 
> And the result is that the current fast syscall handling on x86-64 is
> completely unacceptable.  If it's not change security enhancements are
> not possible since the libc has to hardcode the address.

by the same argument the 2.6 i386 vsyscall is not acceptable too since
it has an hardcoded address too that is the same for all binary kernels
that you ship, and furthmore it has the sysenter or int 0x80 hardcoded
at a fixed address to jump into. In short either you claim the 2.6.2
i386 code as broken the way glibc calls into it, or x86-64 is perfectly
fine too. so your claims makes very little sense to me.
