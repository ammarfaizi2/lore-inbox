Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTJ2RAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 12:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJ2RAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 12:00:19 -0500
Received: from intra.cyclades.com ([64.186.161.6]:18368 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261744AbTJ2RAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 12:00:13 -0500
Date: Wed, 29 Oct 2003 14:51:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Javier Villavicencio <jvillavicencio@arnet.com.ar>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
In-Reply-To: <20031028200544.4e10cc97.jvillavicencio@arnet.com.ar>
Message-ID: <Pine.LNX.4.44.0310291443180.1630-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Oct 2003, Javier Villavicencio wrote:

> On Tue, 28 Oct 2003 17:42:17 -0500
> "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu> wrote:
> 
> > Marcelo Tosatti wrote:
> > 
> > >Joachim, 
> > >The patch in question has caused other problems and will be removed.
> > >  
> > >
> > 
> > Speaking of patches causing problems and needing reversion, can the 
> > screen-corrupting RadeonFB patch introduced in 2.4.23-pre3 be reverted 
> > until such time as it is fixed?  I know there was a maintainer war going 
> > on over who should officially submit RadeonFB patches; somewhere in 
> > there, updates and fixes stopped coming.
> > 
> > As it now stands in current -pre kernels, returning from XFree86 to a 
> > RadeonFB console results in total gibberish all over the screen (with my 
> > hardware anyway, a standard Built-by-ATI Radeon 8500 LE chipset QL 
> > rev0).  There is no workaround, other than to return to X.  Another bug 
> > also causes screen corruption when switching VCs (it forgets where in 
> > the YPan it is), but this can be easily worked around by setting VYRES = 
> > YRES (fbset -match -a).
> > 
> > The previous version of RadeonFB in 2.4.23-pre2 and earlier works just 
> > fine on my Radeon 8500 hardware, albeit without accelerated scrolling.  
> > Of course, if people with other Radeon flavors can't use the older 
> > driver but the newer one works for them, then short of a 
> > CONFIG_OLD_RADEONFB, I guess we should keep the current one...

There have been no radeonfb changes in 2.4.23-pre, what has been updated 
is DRM.

Are you using DRM? 

