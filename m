Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWHUAnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWHUAnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWHUAnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:43:41 -0400
Received: from 1wt.eu ([62.212.114.60]:4881 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932408AbWHUAnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:43:40 -0400
Date: Mon, 21 Aug 2006 02:41:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andreas Steinmetz <ast@domdv.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060821004146.GL602@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <20060817090651.GP7813@stusta.de> <44E433DB.9090501@domdv.de> <20060818232501.GE7813@stusta.de> <20060819044533.GB24543@1wt.eu> <20060821003549.GC11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821003549.GC11651@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 02:35:49AM +0200, Adrian Bunk wrote:
> On Sat, Aug 19, 2006 at 06:45:33AM +0200, Willy Tarreau wrote:
> >...
> > Sometimes it will be compilers, but not by that much. Gcc3.[34] generally
> > produce bigger code than 2.95 at -O2, but I don't think that people in the
> > embedded world still use 2.95 much.
> 
> Comparing code size different gcc versions produce with -O2 is a bit 
> unfair, the size of -Os code is more important in this case.

Yes, but the code produced by gcc-3.[34] -Os is so unoptimized that it's
practically unusable for anything oocasionnaly using the CPU. I use it
mainly for bootloaders and tools like this. On the opposite, gcc-2.95 -Os
was still relatively well optimized, which often resulted in faster execution
due to smaller cache footprint. And for many programs, I have relied on this
combination.

> 
> > Cheers,
> > Willy
> 
> cu
> Adrian

Cheers,
Willy

