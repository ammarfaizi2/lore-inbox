Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVLDUnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVLDUnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLDUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:43:40 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:55428 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932342AbVLDUnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:43:39 -0500
Message-Id: <200512041931.jB4JUIes021111@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Matthias Andree <matthias.andree@gmx.de> 
   of "Sun, 04 Dec 2005 13:07:15 BST." <20051204120715.GB15577@merlin.emma.line.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Dec 2005 16:29:22 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
> On Sat, 03 Dec 2005, Horst von Brand wrote:
> > Matthias Andree <matthias.andree@gmx.de> wrote:
> > > On Sat, 03 Dec 2005, David Ranson wrote:
> > > > Adrian Bunk wrote:
> > > > 
> > > > >- support for ipfwadm and ipchains was removed during 2.6
> > 
> > > > Surely this one had loads of notice though? I was using iptables with
> > > > 2.4 kernels.

> > Sure had. They were scheduled for removal in march, 2005 a long time ago.
> > 
> > > So was I. And now what? ipfwadm and ipchains should have been removed
> > > from 2.6.0 if 2.6.0 was not to support these.
> > 
> > Or in 2.6.10, or 2.6.27, or whatever.

> No. If you need to remove major components, it is only diligent to bump
> the minor revision and call the beast 2.7.0.

In the case of ipfwadm and ipchains, that was precisely the changeover to
2.6... ipfwadm is from 2.2, obsoleted by ipchains in 2.4, and both axed in
the timespan promised.

devfs was never widely used, and was also announced to be killed by 2.6,
IIRC.

>                                              At that time, not only one
> or two subsystems, but all that were marked deprecated for 6 months or
> so, should be dropped.

That /is/ what is happening, modulo needless changes in version number.

> > > This doesn't matter. A kernel that calls itself stable CAN NOT remove
> > > features unless they had been critically broken from the beginning. And
> > > this level of breakage is a moot point, so removal is not justified.
> > 
> > devfs was broken, and very little used.
> 
> OK. This however doesn't hold for ipfwadm (which should probably never
> have made it into 2.6.0 in the first place) or ipchains.

They were carried along exactly to keep the promise of killing them off by a
certain date.

It seems you are going by what is called around here "Palos porque bogas,
palos porque no bogas" (roughly translated, "get whipped for rowing, and
get whipped for not rowing").

> > > Linux 2.6 is not "stable" in this regard.

> > Right. The idea of "stable series" had to go. And went.

> So what is the point in using Linux anyhow if the kernel developers
> don't care for the outside world, one might ask?

Sorry, but again:

- Userland API is remarkably stable, only some stuff with intimate kernel
  connection have ever changed
- In-kernel API has /never/ been stable. At all. Sure, changes are much
  faster now (the community is larger, the tools are better, ....).

>                                                  What is in the way of
> reflecting feature removals in the minor version of the project, say,
> remove devfs, ipfwadm, ipchains and whatnot in one go and call the new
> release without this legacies 2.7.0?

It /was/ called 2.6...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
