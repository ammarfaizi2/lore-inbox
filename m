Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282152AbRKWPat>; Fri, 23 Nov 2001 10:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282170AbRKWPaj>; Fri, 23 Nov 2001 10:30:39 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:26523 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S282152AbRKWPa2>; Fri, 23 Nov 2001 10:30:28 -0500
Date: Fri, 23 Nov 2001 16:30:19 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
Message-ID: <20011123163019.A5418@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <3BFE591B.D1F75CD5@starband.net> <3BFE67E8.CFA0D371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3BFE67E8.CFA0D371@redhat.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.15-pre4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 03:14:48PM +0000, Arjan van de Ven wrote:
> war wrote:
> > 
> > #1) The compiler from redhat (gcc-2.96) is not an official GNU release.
> > #2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
> >       "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"
> 
> From Documentation/Changes in 2.4.15:
> 
> The Red Hat gcc 2.96 compiler subtree can also be used to build this
> tree.
> You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not
> build
> the kernel correctly.

True, but as it's known, gcc-2.96 is NOT an official gcc release by the gcc
team. It was RedHat's fault to fetch a development CVS gcc snapshot and
release it as gcc 2.96 in RedHat distributions, while object format used by
2.96 is not compatible with 2.95 nor 3.0.x at least according information
can be found on site of gcc. It was very ROTFL RedHat to release kgcc to be
able to compile kernel. And these type of distributions are marked as even
enterprise-ready and likes by RedHat :) Sorry for the flame, but IMHO it's
very funny :) [Also, while developing MPlayer we had got problems with even
newer 2.96's, so we do not recommend it in the dox, and ./configure won't
able you to use 2.96 without a special configure switch ...]

But for being more serious: do newer gcc 2.96 versions have these type of
errors? I mean mainly incompatible object format ...

- Gabor
