Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVHKWyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVHKWyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVHKWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:54:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:15558 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932357AbVHKWyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:54:12 -0400
Message-Id: <200508112253.j7BMrqsm016672@laptop11.inf.utfsm.cl>
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd? 
In-Reply-To: Message from DervishD <lkml@dervishd.net> 
   of "Thu, 11 Aug 2005 09:29:29 +0200." <20050811072929.GD1223@DervishD> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 11 Aug 2005 18:53:52 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 11 Aug 2005 18:53:54 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> wrote:
>  * Pete Zaitcev <zaitcev@redhat.com> dixit:
> > On Wed, 10 Aug 2005 21:22:43 +0200, DervishD <lkml@dervishd.net> wrote:
> > >     I'm not using hotplug currently so... how can I make the USB
> > > subsystem to assign always the same /dev/sd? entry to my USB Mass
> > > storage devices? [...]
> > You cannot. Just mount by label or something...

>     Mounting by label won't work, the problem is the /dev entry,
> which changes every time.

That's why you should mount by label...

> > Better yet, install something like Fedora Core 4, which uses HAL,
> > and forget about it. The fstab-sync takes care of the rest.
> 
>     Oh no, thanks, I've already used Fedora and it only reinforced my
> feeling about distros: I prefer my do-it-yourself box ;)

In Fedora rawhide it just works. I can't see how the knot you are tying
yourself into by diy is any better...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
