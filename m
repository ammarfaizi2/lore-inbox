Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266646AbRGJQcy>; Tue, 10 Jul 2001 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbRGJQcp>; Tue, 10 Jul 2001 12:32:45 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:49669 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S266646AbRGJQcf>; Tue, 10 Jul 2001 12:32:35 -0400
Date: Tue, 10 Jul 2001 12:32:30 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: BIOS, Duron4 specifics...
In-Reply-To: <Pine.LNX.4.30.0107101734010.11256-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0107101222560.13575-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Dave Jones wrote:

> On Tue, 10 Jul 2001, John Clemens wrote:
>
> > I've got a new laptop with an AMD Duron in it, based on the Athlon4 core
> > (PowerNow, SSE, hardware prefetch, etc.. Palomino core)..  However, it
> > appears none of the useful features are enabled in the bios.  For example,
> > Nowhere does it appear to enable SSE or the APIC.
>
> afair, the mobile Durons are not based upon the Athlon 4 core, and
> hence won't have the features you mention. You can verify this with
> my x86info tool which you can get from
> ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.3.tgz

Actually, CPUID reports Family 6, Model 6, Rev2, which corellates directly
to Athlon4/MP (Model 6) processors.  Whats surprising is that is doesn't
report model 7, which AMD claims is supposed to be the mobile Duron ;)..
make me wonder if it's really a neutered Athlon4.  Besides, I though the
origional mobile durons (T-bird core, model 3) didn't even support
powernow...?

FYI: This is an HP 5430 notebook.  Duron 850.
http://notebooks.hp-at-home.com/products/notebooks/overview.php?modelNumber=n5430

In either case, i think it really does have all these features, but feel
free to prove me wrong..

> I'd be interested in getting the output of x86info -a on this
> send to me by private mail btw.

will do.  By the way, nice utility!

> The kernel side implementation of this lives in Russell King's CVS.
> Grab it using..
>
> cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
> cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot checkout cpufreq
>
> cvs commit list: http://www.linux.org.uk/mailman/listinfo/cpufreq-commit

Thanks for the pointer.  I'll grab this and have a look at it

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


