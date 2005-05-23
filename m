Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEWHWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEWHWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEWHWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:22:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:35851 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261851AbVEWHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:22:28 -0400
Date: Mon, 23 May 2005 09:21:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
Message-ID: <20050523072101.GA23108@alpha.home.local>
References: <200505220008.j4M08uE9025378@hera.kernel.org> <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org> <20050523040905.GH18600@alpha.home.local> <200505230015.48938.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505230015.48938.dtor_core@ameritech.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 12:15:48AM -0500, Dmitry Torokhov wrote:
> On Sunday 22 May 2005 23:09, Willy Tarreau wrote:
> > Linus,
> > 
> > On Sun, May 22, 2005 at 03:40:24PM -0700, Linus Torvalds wrote:
> > (...)
> > > -        Developer's Certificate of Origin 1.0
> > > +        Developer's Certificate of Origin 1.1
> > (...)
> > >  then you just add a line saying
> > >  
> > >  	Signed-off-by: Random J Developer <random@developer.org>
> > 
> > Why not change this slightly to something like :
> > 
> >        DCO-1.1-Signed-off-by: Random J Developer <random@developer.org>
> > 
> > which would imply that this person has read (and agreed with) version 1.1 ?
> >
> 
> Ugh, that's ugly, long and redundant. You could have:
> 
>       DCO-m.n: Random J Developer <random@developer.org>
> 
> but it still looks ugly.   

Well, it could be anything ugly. The advantage of keeping the "Signed-off-by"
is that tools which already rely on this string will still find it.

Willy

