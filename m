Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWHGP6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWHGP6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHGP6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:58:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:42660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750782AbWHGP6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:58:09 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: x86_64 command line truncated
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44D742DD.6090004@shadowen.org> <p73wt9kprng.fsf@verdi.suse.de>
	<44D75079.5080403@shadowen.org>
	<20060807081519.945df808.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2006 17:58:06 +0200
In-Reply-To: <20060807081519.945df808.akpm@osdl.org>
Message-ID: <p73oduwpmgh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Mon, 07 Aug 2006 15:38:49 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
> > Andi Kleen wrote:
> > > Andy Whitcroft <apw@shadowen.org> writes:
> > > 
> > >> It seems that the command line on x86_64 is being truncated during boot:
> > > 
> > > in mm right?
> > >> Will try and track it down.
> > > 
> > > Don't bother, it is likely "early-param" (the patch from
> > > hell). I'll investigate.
> > > 
> > > -Andi
> > 
> > Well I've narroed it down to the following patch from Andrew:
> > 
> > x86_64-mm-early-param.patch
> 
> Not me.  My only contribution to that patch was to scrog the changelog ;)
> I'll be fixing that sometime.
> 
> I think that patch doesn't have a future, although Andi hasn't yet dropped it.

I fixed all known bugs (but hasn't reached your tree it) and right now 
it looks good to not be a drop.

Of course more testing will tell.

-Andi
