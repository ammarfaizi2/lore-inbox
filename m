Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272784AbSISUGr>; Thu, 19 Sep 2002 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbSISUGr>; Thu, 19 Sep 2002 16:06:47 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:6154 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272784AbSISUGp>;
	Thu, 19 Sep 2002 16:06:45 -0400
Date: Thu, 19 Sep 2002 13:11:40 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20020919201140.GB17131@kroah.com>
References: <20020919125906.21DEA2C22A@lists.samba.org> <Pine.LNX.4.44.0209191532110.8911-100000@serv> <20020919183843.GA16568@kroah.com> <1032461895.27865.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032461895.27865.54.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 07:58:15PM +0100, Alan Cox wrote:
> On Thu, 2002-09-19 at 19:38, Greg KH wrote:
> > And with a LSM module, how can it answer that?  There's no way, unless
> > we count every time someone calls into our module.  And if you do that,
> > no one will even want to use your module, given the number of hooks, and
> > the paths those hooks are on (the speed hit would be horrible.)
> 
> So the LSM module always says no. Don't make other modules suffer

Ok, I don't have a problem with that, I was just trying to point out
that not all modules can know when they are able to be unloaded, as
Roman stated.

thanks,

greg k-h
