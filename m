Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbTC1JgF>; Fri, 28 Mar 2003 04:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbTC1JgF>; Fri, 28 Mar 2003 04:36:05 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:13579 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262846AbTC1JgE>; Fri, 28 Mar 2003 04:36:04 -0500
Date: Fri, 28 Mar 2003 10:47:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030327234820.GE1687@kroah.com>
Message-ID: <Pine.LNX.4.44.0303281031120.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Mar 2003, Greg KH wrote:

> > > Devices.txt or dynamic assignment
> > 
> > The first case means a /dev directory with millions of dev entries.
> > How does the user find out about the number of partitions in the second 
> > case?
> 
> They point and guess, just like they do today :)

I think the users which need this most won't be particular happy.

> > > > Who creates these device entries (user or daemon)?
> > > 
> > > Who cares 8)  Thats just the devfs argument all over again 8)
> > 
> > Why? I specifically didn't mention the kernel.
> > Anyone has to care, somehow this large number space must be managed.
> 
> Yes, some of us are working on this.  But this has nothing to do with
> the kernel, or Andries's patches.  It's a userspace issue.

Somehow the kernel and the userspace have to work together. What I want to 
know is whether we just create another crutch, barely usable for the 
desperate or if we create a solution which has a small chance to still 
work in the future.

bye, Roman

