Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUIGVJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUIGVJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUIGVI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:08:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15861 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S268646AbUIGVHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:07:03 -0400
Date: Tue, 7 Sep 2004 14:06:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update arch/ppc/defconfig
Message-ID: <20040907210659.GI20951@smtp.west.cox.net>
References: <20040907200013.GA14330@suse.de> <20040907202218.GH20951@smtp.west.cox.net> <20040907204135.GA14700@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907204135.GA14700@suse.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 10:41:35PM +0200, Olaf Hering wrote:
>  On Tue, Sep 07, Tom Rini wrote:
> 
> > Is it all that common for pmacs to be using a serial console?
> 
> It cant hurt.
> 
> > If that's working again, we should enable it, Mot PRePs have those
> > cards.
> 
> It doesnt work for me right now.

Doesn't compile or doesn't work on your prep board?

> > Er, is there a good reason to have only the 16color one?
> 
> Why have all 3 enabled?

Because that's the way they are.  And I always pick CLUT244 for my
machiens :)

> > > +CONFIG_JOLIET=y
> > > +CONFIG_ZISOFS=y
> > > +CONFIG_ZISOFS_FS=y
> > 
> > Ick, please no.
> 
> Why not?

Because this is a basic config.

> > > +CONFIG_CRAMFS=m
> > 
> > Why?
> 
> Why not?

It's not needed or required.

> > > +#
> > >  # Kernel hacking
> > >  #
> > > -# CONFIG_DEBUG_KERNEL is not set
> > > +CONFIG_DEBUG_KERNEL=y
> > 
> > Why?
> 
> having sysrq is always a win.

Only when you can see the output.  Or do you mean SysRq-S-U-B? :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
