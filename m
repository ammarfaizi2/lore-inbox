Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVL1Tca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVL1Tca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVL1Tca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:32:30 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:60992 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964889AbVL1Tc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:32:29 -0500
Subject: Re: ati X300 support?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: chris@pcburn.com, Gerhard Mack <gmack@innerfire.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512272320.45378.s0348365@sms.ed.ac.uk>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
	 <200512271603.30939.s0348365@sms.ed.ac.uk> <43B1BFB8.8050207@pcburn.com>
	 <200512272320.45378.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 20:32:10 +0100
Message-Id: <1135798330.16657.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 23:20 +0000, Alistair John Strachan wrote:
> On Tuesday 27 December 2005 22:27, Chris Bergeron wrote:
> > Alistair John Strachan wrote:
> > >On Tuesday 27 December 2005 15:57, Gerhard Mack wrote:
> > >>I have it working in X.org with no problem.  I just can't get the drm
> > >>module working in the kernel.  Last time I tried to just add my PCI ids
> > >>the problem was a lack of PCIE support in the drm drivers.
> > >
> > >I'd try again, I have a vague memory of reading a changelog a few releases
> > > ago that mentioned PCIe support in radeon-drm.
> > >
> > >>FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their
> > >>drivers up to date at all and the result is that they finally have
> > >>working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still
> > >>broken on any recent kernel and it's been that way for months.  ATI's
> > >> tech support basically gave up after several days and just informed me
> > >> it wasn't really supported and there is nothing they could do for me.
> > >
> > >You're better off running open source drivers anyway, it's less hassle,
> > > you don't have to worry about every kernel upgrade breaking them, and
> > > it's only an X300 anyway -- on my Mobility 9600, I just play a few small
> > > games and expect OpenGL accelerated applications to work properly.
> > >
> > >If your goals are similar, they're probably achievable with mainline.
> >
> > The DRI project only supports up to the Radeon 9200 unless I missed an
> > update and their page is outdated.  Check the DRI ATI page for details.
> >
> > http://dri.freedesktop.org/wiki/ATI
> 
> Yes, you and this link are both out of date. The r300 driver provides basic 
> support for many newer video cards based on the r300 core and is shipped with 
> Xorg 7.0.0.
is this only 7.0.0? i just built 6.9 and i dont have the 'r300' x
driver, or... is it merged into the 'ati' or 'radeon' xorg driver
module?
> 

