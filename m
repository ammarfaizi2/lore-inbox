Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUE1JDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUE1JDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUE1JDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:03:52 -0400
Received: from av7-1-sn2.hy.skanova.net ([81.228.8.108]:18830 "EHLO
	av7-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262382AbUE1JDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:03:50 -0400
X-Mailer: exmh version 2.6.3 04/02/2003 (gentoo 2.6.3) with nmh-1.1
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Mark Beyer - Contractor <mbeyer@unminc.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: future of UMSDOS? 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Thu, 27 May 2004 22:28:38 +0200." <20040527202837.GV16099@fs.tum.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 May 2004 11:03:44 +0200
From: aeriksson@fastmail.fm
Message-Id: <20040528090345.6C6913F04@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk wrote:
> On Mon, May 24, 2004 at 10:19:09AM -0700, Mark Beyer - Contractor wrote:
> > Jan-Benedict Glaw wrote:
> > 
> > >On Wed, 2004-05-19 20:43:21 +0200, Adrian Bunk <bunk@fs.tum.de>
> > >wrote in message <20040519184321.GB24287@fs.tum.de>:
> > > 
> > >
> > >>Looking at the state of the UMSDOS code in 2.6 I'm currently wondering 
> > >>about it's future.
> > >>
> > >>Are there still potential users and people willing to work on getting it
> > >>working, or should it be removed from kernel 2.6?
> > >>   
> > >>
> > >
> > >In my early Linux days, UMSDOS was quite a neat thing to have for
> > >showing Linux to friends by placing a .zip'ed Linux installation on
> > >their MS-DOS machines.
> > >
> > >So for historic reasons, I think it would be nice to have UMSDOS around.
> > > 
> > >
> > There are still embedded systems that boot from a DOS file system. Yes, 
> > there are better methods but for backward compatibility I wouldn't like 
> > to see it removed.
> 
> It's broken in 2.6.
> 
> Does anyone need it enough to fix it?
> 


UMSDOS as-is, no not really, but I would like to see it ported to run
on top of smb. Being able to have an smb equivalent to nfsroot would
be really cool for disk space limited laptops and the like where you
want to run e.g. colinux. All you'd need is a vmlinuz file, a small
initrd file, and you're set to go. No need for
filesystems-on-big-files and such workarounds...

How much work would this take? I had a glance at the UMSDOS code and
it _seems_ rather light, but it's unchartered territory for me...

/A


