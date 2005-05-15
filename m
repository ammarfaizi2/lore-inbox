Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVEOOVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVEOOVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVEOOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:21:39 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9652 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261641AbVEOOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:21:36 -0400
Date: Sun, 15 May 2005 16:21:36 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050515141207.GB94354@muc.de>
Message-ID: <Pine.LNX.4.58.0505151616130.15022@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
 <20050513211609.75216bf8.diegocg@gmail.com> <20050515095446.GE68736@muc.de>
 <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
 <20050515141207.GB94354@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 May 2005, Andi Kleen wrote:

> On Sun, May 15, 2005 at 03:51:05PM +0200, Mikulas Patocka wrote:
> >
> >
> > On Sun, 15 May 2005, Andi Kleen wrote:
> >
> > > On Fri, May 13, 2005 at 09:16:09PM +0200, Diego Calleja wrote:
> > > > El Fri, 13 May 2005 20:03:58 +0200,
> > > > Andi Kleen <ak@muc.de> escribi?:
> > > >
> > > >
> > > > > This is not a kernel problem, but a user space problem. The fix
> > > > > is to change the user space crypto code to need the same number of cache line
> > > > > accesses on all keys.
> > > >
> > > >
> > > > However they've patched the FreeBSD kernel to "workaround?" it:
> > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch
> > >
> > > That's a similar stupid idea as they did with the disk write
> > > cache (lowering the MTBFs of their disks by considerable factors,
> > > which is much worse than the power off data loss problem)
> > > Let's not go down this path please.
> >
> > What wrong did they do with disk write cache?
>
> They turned it off by default, which according to disk vendors
> lowers the MTBF of your disk to a fraction of the original value.
>
> I bet the total amount of valuable data lost for FreeBSD users because
> of broken disks is much much bigger than what they gained from not losing
> in the rather hard to hit power off cases.
>
> -Andi

BTW. Is there any blacklist of disks with broken FLUSH CACHE command? Or a
list of companies that cheat in implementation of it?

Mikulas
