Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVEONvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEONvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 09:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEONvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 09:51:10 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45489 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261626AbVEONvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 09:51:05 -0400
Date: Sun, 15 May 2005 15:51:05 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050515095446.GE68736@muc.de>
Message-ID: <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
 <20050513211609.75216bf8.diegocg@gmail.com> <20050515095446.GE68736@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 May 2005, Andi Kleen wrote:

> On Fri, May 13, 2005 at 09:16:09PM +0200, Diego Calleja wrote:
> > El Fri, 13 May 2005 20:03:58 +0200,
> > Andi Kleen <ak@muc.de> escribi?:
> >
> >
> > > This is not a kernel problem, but a user space problem. The fix
> > > is to change the user space crypto code to need the same number of cache line
> > > accesses on all keys.
> >
> >
> > However they've patched the FreeBSD kernel to "workaround?" it:
> > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch
>
> That's a similar stupid idea as they did with the disk write
> cache (lowering the MTBFs of their disks by considerable factors,
> which is much worse than the power off data loss problem)
> Let's not go down this path please.

What wrong did they do with disk write cache?

Mikulas

> -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
