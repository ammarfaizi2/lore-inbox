Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUKRWe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUKRWe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUKRWdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:33:08 -0500
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:42214
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S261182AbUKRWcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:32:43 -0500
Date: Thu, 18 Nov 2004 17:31:32 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
In-Reply-To: <20041118213232.GG4943@stusta.de>
Message-ID: <Pine.LNX.4.61.0411181727010.12260@xanadu.home>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de>
 <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0411181132440.12260@xanadu.home> <20041118213232.GG4943@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Adrian Bunk wrote:

> On Thu, Nov 18, 2004 at 11:34:56AM -0500, Nicolas Pitre wrote:
> > On Thu, 18 Nov 2004, David Woodhouse wrote:
> > 
> > > On Thu, 2004-11-18 at 16:41 +0100, Adrian Bunk wrote:
> > > > Let's put the dependencies from the #error into the Kconfig file:
> > > 
> > > Looks sane to me. Nico?
> > 
> > And why is the current arrangement actually a problem?
> 
> If you are able to select an option, it should also compile (and work).
> 
> At least on i386, this is usually true for every single option.

Fine.  I thought the #error would encourage people to add the missing 
bits to that file.  No?  ;-)

Can we make it conditional on CONFIG_XIP_KERNEL instead?
It would be less messy IMHO.


Nicolas
