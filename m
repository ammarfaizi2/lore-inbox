Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbTFVTpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265822AbTFVTpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:45:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265816AbTFVTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:45:04 -0400
Date: Sun, 22 Jun 2003 21:07:12 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306222007.h5MK7CS7000136@81-2-122-30.bradfords.org.uk>
To: akpm@digeo.com, hps@intermeta.de
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the build system is OK.  And ccache nicely fixes up any mistakes which
> the build system makes, and distcc speeds things up by 2x to 3x.
>
> None of that gets around the fact that code needs to be tested with various
> combinations of CONFIG_SMP, CONFIG_PREEMPT, different subarchitectures,
> spinlock debugging, etc, etc.  If the compiler is slow people don't bother
> doing this and the code breaks.
>
> Cause and effect.

Are the benchmarks that show gcc 3.3 to be much slower at compile time
being done with a natively compiled gcc 3.3?  I.E. gcc 3.3 compiled
with itself?

When I upgraded a few machines from 2.95.3 to 3.2.3, I noticed that
the last of the three compiles, (I.E. a gcc-3.2.3 compiled gcc-3.2.3
compiling the gcc-3.2.3 source), was noticably quicker than the first
two, to the extent that it was easily mesaurable by a wall clock.

I am just wondering whether there gcc-3.X binaries in use that were
compiled with gcc-2.95.3, that are swaying benchmarks in favour of
2.95.3 compiled with itself.

I haven't benchmarked gcc-2.95.3 compiled with gcc-3.2.3, though.

John.
