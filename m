Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUA1RFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266122AbUA1RFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:05:33 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:34500 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266105AbUA1RF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:05:26 -0500
Date: Wed, 28 Jan 2004 10:05:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040128170520.GI6577@stop.crashing.org>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128165104.GC1200@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 05:51:05PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Hello everybody.  Since I've been talking with George off-list about
> > trying to merge the various versions of KGDB around, and I just read the
> > thread between Andy and Jim about conflicting on KGDB work, I've put up
> > a BitKeeper repository[1] to try and coordinate things.
> > 
> > What's in there right now is Amit's kgdb 2.1.0, without the ethernet
> > patch.   There's also all of the changes for PPC and for generic stuffs
> > that I've been doing of late.
> > 
> > What I'll be doing shortly (this afternoon even) is to change from a
> > struct of function pointers, for the arch specific functions, into a set
> > of provided, weak, variants and then allow arches to override as needed.
> > 
> > What I'd like is for someone to move the ethernet bits from the -mm tree
> > into here, and for people to merge the fixes / enhancements that're in
> > their per-arch stubs in the -mm tree into the split design that Amit's
> > version has.
> > 
> > Comments? Screams? Patches? :)
> 
> This one. It compiles. It needs -netpoll. It probably does not work.

Er, what's this against?  I don't have drivers/net/kgdb_eth.c in my repo
right now (nor the -netpoll patch, but I'll happily take a patch to add
the kgdb over enet stub and -netpoll).

-- 
Tom Rini
http://gate.crashing.org/~trini/
