Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274186AbRITCgH>; Wed, 19 Sep 2001 22:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274229AbRITCf5>; Wed, 19 Sep 2001 22:35:57 -0400
Received: from [195.223.140.107] ([195.223.140.107]:26358 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274186AbRITCfy>;
	Wed, 19 Sep 2001 22:35:54 -0400
Date: Thu, 20 Sep 2001 04:36:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shane Wegner <shane@cm.nu>
Cc: Martin MOKREJ? <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010920043611.M720@athlon.random>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu> <20010920004543.Z720@athlon.random> <20010919193128.A8650@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919193128.A8650@cm.nu>; from shane@cm.nu on Wed, Sep 19, 2001 at 07:31:28PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:31:28PM -0700, Shane Wegner wrote:
> On Thu, Sep 20, 2001 at 12:45:43AM +0200, Andrea Arcangeli wrote:
> > On Wed, Sep 19, 2001 at 03:34:41PM -0700, Shane Wegner wrote:
> > > 
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > 
> > yes, please try this fix and let me know if it helps:
> 
> After some stress testing, the fix does appear to fix the
> error.

good, what about the performance, is it all right?

Andrea
