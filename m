Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274927AbSITE1q>; Fri, 20 Sep 2002 00:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274929AbSITE1q>; Fri, 20 Sep 2002 00:27:46 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:11019 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274927AbSITE1p>;
	Fri, 20 Sep 2002 00:27:45 -0400
Date: Thu, 19 Sep 2002 21:32:36 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20020920043236.GA19637@kroah.com>
References: <20020919183843.GA16568@kroah.com> <20020920040241.4C03F2C0D9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920040241.4C03F2C0D9@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 11:22:08AM +1000, Rusty Russell wrote:
> In message <20020919183843.GA16568@kroah.com> you write:
> > On Thu, Sep 19, 2002 at 03:54:40PM +0200, Roman Zippel wrote:
> > > I already said often enough, a module has only to answer the simple
> > > question: Is it safe to unload the module?
> > 
> > And with a LSM module, how can it answer that?  There's no way, unless
> > we count every time someone calls into our module.  And if you do that,
> > no one will even want to use your module, given the number of hooks, and
> > the paths those hooks are on (the speed hit would be horrible.)
> 
> Well, it's up to you.  You *could* implement:

<snip>

Ok, now that's just sick and twisted enough that it might just work.  I
really don't want to use a macro for the security functions, but this
provides type safety, and... well...  I'm at a loss of words, and just
amazed...

greg k-h
