Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVHEK4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVHEK4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVHEK4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:56:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42909 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262957AbVHEK4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:56:46 -0400
Date: Fri, 5 Aug 2005 12:56:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <1123238289.3239.57.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0508051254010.3743@scrub.home>
References: <1123219747.20398.1.camel@localhost>  <20050804223842.2b3abeee.akpm@osdl.org>
  <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> 
 <20050804233634.1406e92a.akpm@osdl.org>  <Pine.LNX.4.61.0508051132540.3743@scrub.home>
  <1123235219.3239.46.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051202520.3728@scrub.home>
  <1123236831.3239.55.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051225270.3743@scrub.home>
 <1123238289.3239.57.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Aug 2005, Arjan van de Ven wrote:

> > > we've had a non-negliable amount of security holes because of this
> > 
> > So why don't we have a similiar kmalloc()?
> 
> nope kmalloc is not an array allocator
> 
> > > it makes it easy and safe. Of course you can and should check it in all
> > > users. Just that using a safer API is generally better than forcing
> > > everyone to do it themselves.
> > 
> > How exactly does this make it a "safe API"? Even if it checks for this one 
> > case, it still makes the user suspectible for allocating big amounts of 
> > unswappable memory.
> 
> 128Kb max.

You completely missed the point and didn't answer my questions at all... :-(

bye, Roman
