Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKHMYi>; Thu, 8 Nov 2001 07:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277317AbRKHMY3>; Thu, 8 Nov 2001 07:24:29 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:60171 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S275224AbRKHMYU>; Thu, 8 Nov 2001 07:24:20 -0500
Date: Thu, 8 Nov 2001 13:24:10 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Samium Gromoff <_deepfire@mail.ru>
cc: Dominik Kubla <kubla@sciobyte.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Laptop harddisk spindown?
In-Reply-To: <200111080502.fA852im17980@vegae.deep.net>
Message-ID: <Pine.LNX.4.40.0111081319330.26547-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, Nov 08, 2001 at 01:51:05AM +0300, Samium Gromoff wrote:
> > >      I`m sorry folks, i dont quite recall whether i poked lkml with that,
> > >   but here it is:
> > > 	2.4.13, reiserfs
> > > 	i have a disk access _every_ 5 sec, unregarding the system load,
> > >     24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
> > >     bound boxes...
> > >         I must add that i `m experiencing this on -ac tree too, adn this is true
> > >     as far as my memory goes... (in the kernel-version context i mean)

Did you mount your partitions with "noatime"?

This (and not keeping Mozilla open) does the trick on my laptop, the
harddisk goes off after about 30 seconds and if I don't do anything local,
it stays off.

(Debian unstable, Kernel 2.4.12-ac6 currently)

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

