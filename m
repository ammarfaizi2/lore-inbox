Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284421AbRLDCEf>; Mon, 3 Dec 2001 21:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281855AbRLDCDB>; Mon, 3 Dec 2001 21:03:01 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:17396 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S283071AbRLDCCj>;
	Mon, 3 Dec 2001 21:02:39 -0500
Date: Mon, 3 Dec 2001 21:09:18 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.40.0112031722060.1381-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001, Davide Libenzi wrote:

> On Mon, 3 Dec 2001, Donald Becker wrote:
> > of the change.  We won't know for years if redesigning the kernel for
> > large scale SMP system is useful
> >   - does it actually work,
> >   - will big SMP machines be common, or even exist?
> >   - will big SMP machines have the characteristics we predict
> > let alone worth the costs such as
> >   - UP performance hit
> >   - complexity increase slows other improvements
> >   - difficult performance tuning
...
> No, I do not believe in 128 single CPU SMP machines but, if I've to watch
> inside my pretty dirty crystal ball, I see multi-core CPUs as a technology
> response to SMP request.
> Yes, because after the 1st theorem of "work" there's the 1st lemma of
> technology that states that "technology will always follow the
> market request".

You haven't addressed the points above.
We haven't established that the market will request substantial numbers
of 128-way SMPs.  Even if they do request single-address-space
multiprocessors, it's very likely that the result will be some form of cc-numa
where the structure will strongly influence the OS to treat the machine
as something besides a SMP.

To bring this branch back on point: we should distinguish between
design for an arbitrary and unpredictable goal (e.g. 128 way SMP)
vs. putting some design into things that we are supposed to already
understand
   a SCSI device layer that isn't three half-finished clean-ups
   a VFS layer that doesn't require the kernel to know a priori all of
     the filesystem types that might be loaded


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

