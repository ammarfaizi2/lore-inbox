Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317438AbSFCRs0>; Mon, 3 Jun 2002 13:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSFCRsZ>; Mon, 3 Jun 2002 13:48:25 -0400
Received: from pop.gmx.net ([213.165.64.20]:35837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317438AbSFCRsZ>;
	Mon, 3 Jun 2002 13:48:25 -0400
Date: Mon, 3 Jun 2002 20:47:02 +0300
From: Dan Aloni <da-x@gmx.net>
To: jt@hpl.hp.com
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-(
Message-ID: <20020603174702.GA1488@callisto.yi.org>
In-Reply-To: <20020601065520.GA11951@callisto.yi.org> <Pine.LNX.4.44.0206010235340.21152-100000@chaos.physics.uiowa.edu> <20020603101447.A6067@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 10:14:47AM -0700, Jean Tourrilhes wrote:
> On Sat, Jun 01, 2002 at 02:43:14AM -0500, Kai Germaschewski wrote:
> > On Sat, 1 Jun 2002, Dan Aloni wrote:
> > 
> > > > 	So, I was trying to fix that, and I found a problem with
> > > > kernel link order.
> > > 
> > > It is possible that recent kbuild changes caused that.
> > 
> > I don't think so, I took extra care to leave it all the same. (Well, 
> > except for sound/, which is outside drivers/) It'd however surely be a 
> > good idea to go through it and document which dependencies there are.
> 
>	Obviously Dan didn't bother to read my e-mail. The problem is
>  definitely not with kbuild. The problem is with the
> __define_initcall() levels.

I did in fact read your e-mail. I was just suggesting something that is 
drawn from previous experience concerning dependency problems with drivers 
compiled in as non-modules. And in my e-mail I was suggesting a workaround 
to make sure stuff gets initialized regardless of __initcall() levels.

-- 
Dan Aloni
da-x@gmx.net
