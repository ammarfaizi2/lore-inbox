Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSLJOlI>; Tue, 10 Dec 2002 09:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLJOlH>; Tue, 10 Dec 2002 09:41:07 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:61901 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261854AbSLJOlH>; Tue, 10 Dec 2002 09:41:07 -0500
Date: Tue, 10 Dec 2002 14:48:52 +0000
From: Dave Jones <davej@suse.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210144852.GD26361@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039538881.2025.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 09:47:24PM +0500, Antonino Daplas wrote:
 > On Tue, 2002-12-10 at 18:11, Dave Jones wrote:
 > > On Tue, Dec 10, 2002 at 05:21:29PM +0500, Antonino Daplas wrote:
 > >  > 2.  The i810 driver for Xfree86 will also fail to load because of
 > >  > version mismatch (0.99 vs 1.0).  Rolling back the version corrects the
 > >  > problem.
 > > 
 > > Ugh, that's great. So X has to be patched every time the agpgart code
 > > gets a new revision ? That sounds really unpleasant.
 > > 
 > Actually, X is complaining that the kernel version was too old, crazy
 > no?

That chunk of X code is crap. So much so, that someone even put a
comment there (not that what they suggested was much better).

See line 122 of http://www.atomised.org/docs/XFree86-4.2.1/agp_8c-source.html

        Dave

