Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWB0EvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWB0EvY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWB0EvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:51:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750745AbWB0EvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:51:24 -0500
Date: Sun, 26 Feb 2006 20:50:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm2 configs
Message-Id: <20060226205028.789b9ca7.akpm@osdl.org>
In-Reply-To: <20060226195531.ee1ca136.rdunlap@xenotime.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30062E9D71@hdsmsx401.amr.corp.intel.com>
	<20060226195109.051bb53f.akpm@osdl.org>
	<20060226195531.ee1ca136.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Sun, 26 Feb 2006 19:51:09 -0800 Andrew Morton wrote:
> 
> > "Brown, Len" <len.brown@intel.com> wrote:
> > >
> > >  
> > > >> a.  why does SONY_ACPI default to m ?  Other similar options 
> > > >are default n.
> > > >
> > > >Because I got heartily sick of losing the setting each time I 
> > > >went back to a mainline kernel and did `make oldconfig'.
> > > 
> > > IIR the recommendation from Roman on these things was
> > > to remove the default entirely.  If you have a favorite
> > > .config file with =m in it, then make oldconfig should
> > > preserve that choice.
> > > 
> > 
> > Nope.  Once you remove the Kconfig entry entirely (ie: go back to a
> > mainline kernel), `make oldconfig' will rub that config entry out
> > completely.
> 
> Yes.  So you have it =m so that it will build in your
> test builds, right?  or some other reason?
> 

As I said, I got tired of losing the setting and not being able to control
the backlight brightness.  <insert anecdote about sitting outside at son's
basketball game, having to recompile entire kernel by smell so I could read
the screen>

