Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTIBUtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTIBUtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:49:08 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:63492 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264372AbTIBUtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:49:02 -0400
Date: Tue, 2 Sep 2003 17:51:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
In-Reply-To: <20030901190526.GP11503@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0309021751020.7835-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Sep 2003, Andrea Arcangeli wrote:

> On Mon, Sep 01, 2003 at 04:00:49PM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Sat, 30 Aug 2003, Andrea Arcangeli wrote:
> > 
> > > On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > > > 
> > > > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > > > Andrea to get his stuff in, I doubt you will fair any better.
> > > > 
> > > > Thats because I never received separate patches which make sense one by
> > > > one.  Most of Andreas changes are all grouped into few big patches that
> > > > only he knows the mess. That is not the way to merge things.
> > > > 
> > > > I want to work out with him after I merge other stuff to address that.
> > > 
> > > that's true for only one patch, the others are pretty orthogonal after
> > > Andrew helped splitting them:
> > > 
> > > 
> > > 05_vm_03_vm_tunables-4
> > > 05_vm_05_zone_accounting-2
> > > 05_vm_06_swap_out-3
> > > 05_vm_07_local_pages-4
> > > 05_vm_08_try_to_free_pages_nozone-4
> > > 05_vm_09_misc_junk-3
> > > 05_vm_10_read_write_tweaks-3
> > > 05_vm_13_activate_page_cleanup-1
> > > 05_vm_15_active_page_swapout-1
> > > 05_vm_16_active_free_zone_bhs-1
> > > 05_vm_17_rest-10
> > 
> > Can you please split the watermark changes from 05_vm_rest-10 and send me
> > that ? (no waitqueue changes, no page wakeup logic changes)
> 
> yes sure. (I have it already splitted here but I'm unsure if it's
> uptodate or/and if still applies:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6/zone-watermarks-1
> 
> so don't use it, I'll send a new one).

Any progress? 8) 

