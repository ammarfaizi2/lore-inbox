Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbTC0XiL>; Thu, 27 Mar 2003 18:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTC0XiL>; Thu, 27 Mar 2003 18:38:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15369 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261546AbTC0XiK>;
	Thu, 27 Mar 2003 18:38:10 -0500
Date: Thu, 27 Mar 2003 15:48:20 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030327234820.GE1687@kroah.com>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0303280008530.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303280008530.5042-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 12:19:25AM +0100, Roman Zippel wrote:
> > > How will the user know about these numbers?
> > 
> > Devices.txt or dynamic assignment
> 
> The first case means a /dev directory with millions of dev entries.
> How does the user find out about the number of partitions in the second 
> case?

They point and guess, just like they do today :)

> > > Who creates these device entries (user or daemon)?
> > 
> > Who cares 8)  Thats just the devfs argument all over again 8)
> 
> Why? I specifically didn't mention the kernel.
> Anyone has to care, somehow this large number space must be managed.

Yes, some of us are working on this.  But this has nothing to do with
the kernel, or Andries's patches.  It's a userspace issue.

thanks,

greg k-h
