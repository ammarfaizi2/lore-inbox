Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUCWM0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUCWM0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:26:33 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:62898 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262503AbUCWM0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:26:31 -0500
Date: Tue, 23 Mar 2004 13:26:27 +0100
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Message-ID: <20040323122627.GA22830@lambda>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <1079909446.911.165.camel@gaston> <20040322195720.GA27480@kroah.com> <200403231211.09334.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200403231211.09334.lkml@kcore.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:11:00PM +0100, Jan De Luyck wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 22 March 2004 20:57, Greg KH wrote:
> > On Mon, Mar 22, 2004 at 09:50:46AM +1100, Benjamin Herrenschmidt wrote:
> > > > I prefere graphics myself. Display sounds to generic. That is what
> > > > video and graphics output is piped to. Since fbdev doesn't handle video
> > > > ouput normally this is kind of fuzzy sounding.
> > >
> > > I still prefer display...
> >
> > Bah, I don't want to argue here.  I've applied Kronos's patch as is to
> > my device-2.6 tree which will end up in the next -mm release.
> >
> > I'll hold off forwarding this patch to Linus until after 2.6.5 is out,
> > so that gives everyone a few days in which to argue the name a bunch and
> > then send me a patch that changes it to the decided apon name (if it is
> > to be changed.)
> 
> - From a users point of view: if there are only to be framebuffer devices listed 
> in this class, why not call it just what it is: "Framebuffer" ? Naming it 
> after something it is only in a broad sense makes no sense to me. I'd be 
> looking in /sys/.../framebuffer instead of /sys/.../graphics or /display.

Notice that /display is what is used by most OF implementations, so this
kinda makes sense. I would vote like BenH on this if i was consulted.

> Display would be the EDID info of my screen (physical), and graphics... 
> well... I'd half expect something like capture cards to be there...

But this also makes sense, still, i guess we are concerned with more
info than just the framebuffer, right ? 

Friendly,

Sven Luther
