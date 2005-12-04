Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVLDMHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLDMHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 07:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVLDMHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 07:07:22 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:31154 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932201AbVLDMHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 07:07:21 -0500
Date: Sun, 4 Dec 2005 13:07:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204120715.GB15577@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <matthias.andree@gmx.de> <20051203222731.GC25722@merlin.emma.line.org> <200512040106.jB415cqb023723@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512040106.jB415cqb023723@pincoya.inf.utfsm.cl>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Horst von Brand wrote:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> > On Sat, 03 Dec 2005, David Ranson wrote:
> > > Adrian Bunk wrote:
> > > 
> > > >- support for ipfwadm and ipchains was removed during 2.6
> 
> > > Surely this one had loads of notice though? I was using iptables with
> > > 2.4 kernels.
> 
> Sure had. They were scheduled for removal in march, 2005 a long time ago.
> 
> > So was I. And now what? ipfwadm and ipchains should have been removed
> > from 2.6.0 if 2.6.0 was not to support these.
> 
> Or in 2.6.10, or 2.6.27, or whatever.

No. If you need to remove major components, it is only diligent to bump
the minor revision and call the beast 2.7.0. At that time, not only one
or two subsystems, but all that were marked deprecated for 6 months or
so, should be dropped.

> > This doesn't matter. A kernel that calls itself stable CAN NOT remove
> > features unless they had been critically broken from the beginning. And
> > this level of breakage is a moot point, so removal is not justified.
> 
> devfs was broken, and very little used.

OK. This however doesn't hold for ipfwadm (which should probably never
have made it into 2.6.0 in the first place) or ipchains.

> > Linux 2.6 is not "stable" in this regard.
> 
> Right. The idea of "stable series" had to go. And went.

So what is the point in using Linux anyhow if the kernel developers
don't care for the outside world, one might ask? What is in the way of
reflecting feature removals in the minor version of the project, say,
remove devfs, ipfwadm, ipchains and whatnot in one go and call the new
release without this legacies 2.7.0?

-- 
Matthias Andree
