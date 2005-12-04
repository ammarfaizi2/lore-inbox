Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVLDB52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVLDB52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLDB52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:57:28 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:30116 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1751311AbVLDB51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:57:27 -0500
Message-Id: <200512040106.jB415cqb023723@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Matthias Andree <matthias.andree@gmx.de> 
   of "Sat, 03 Dec 2005 23:27:31 BST." <20051203222731.GC25722@merlin.emma.line.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sat, 03 Dec 2005 22:04:42 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
> On Sat, 03 Dec 2005, David Ranson wrote:
> > Adrian Bunk wrote:
> > 
> > >- support for ipfwadm and ipchains was removed during 2.6

> > Surely this one had loads of notice though? I was using iptables with
> > 2.4 kernels.

Sure had. They were scheduled for removal in march, 2005 a long time ago.

> So was I. And now what? ipfwadm and ipchains should have been removed
> from 2.6.0 if 2.6.0 was not to support these.

Or in 2.6.10, or 2.6.27, or whatever.

>                                               That opportunity was
> missed, the removal wasn't made up for in 2.6.1, so the stuff has to
> stick until 2.8.0.

Sorry, but the new development model is that there is no "uneven" series
anymore. Sure, it /might/ open for worldshattering changes, but nothing of
that sort is remotely in sight right now, so...

> > >- devfs support was removed during 2.6
> >
> > Did this affect many 'real' users?

> This doesn't matter. A kernel that calls itself stable CAN NOT remove
> features unless they had been critically broken from the beginning. And
> this level of breakage is a moot point, so removal is not justified.

devfs was broken, and very little used.

> > >- removal of kernel support for pcmcia-cs is pending
> > >- ip{,6}_queue removal is pending
> > >- removal of the RAW driver is pending
> 
> > I don't use any of these. I guess pcmcia-cs may be disruptive for laptop
> > users.

> Who cares what you or I use? It's a commonly acknowledged policy that
> "stable" releases do not remove features that are good enough for some.

Right, for a suitably large set of "some". If the set is too small...

> Linux 2.6 is not "stable" in this regard.

Right. The idea of "stable series" had to go. And went.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
