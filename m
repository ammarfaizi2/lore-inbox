Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUDSGme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbUDSGme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:42:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:17612 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263207AbUDSGmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:42:33 -0400
Date: Sun, 18 Apr 2004 23:42:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-Id: <20040418234214.7bfb5392.akpm@osdl.org>
In-Reply-To: <20040419062914.GE743@holomorphy.com>
References: <20040418230131.285aa8ae.akpm@osdl.org>
	<20040419062914.GE743@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sun, Apr 18, 2004 at 11:01:31PM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc1/2.6.6-rc1-mm1/
> > - All of the anonmm rmap work is now merged up.  No pte chains.
> > - Various cleanups and fixups, as usual.
> > - The list of external bk trees is getting a little short, due to problems
> >   at bkbits.net.  The ones which are here are not necessarily very up-to-date
> >   with the various development trees.
> 
> Okay, the cpumask_arith.h fixes aren't in here. What do I have to do to
> get the bare minimal correctness fixes in this area propagated to mainline?
> 
> The important aspect of these is that they're pertinent to small SMP
> systems, for instance, the dual Pee Cee shenanigans with all kinds of pins
> clipped along with all the other things used in larger boxen castrated.
> 

I confess to being moderately exhasperated at the amount of talk and
patching going on in the bitmap and cpumask areas.  So when your patch
floated past with a terse description which was bristling with ifs, buts
and maybes I decided to take a pass.  

If you want to send it again, cc'ing your co-conspirators and imparting some
confidence that this darned thing is actually meandering toward a conclusion,
please feel free ;)

