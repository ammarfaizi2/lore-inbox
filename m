Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWITNPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWITNPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWITNPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:15:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49056 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751237AbWITNPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:15:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.18-rc7-mm1
Date: Wed, 20 Sep 2006 15:18:22 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060919012848.4482666d.akpm@osdl.org> <20060919133606.f0c92e66.akpm@osdl.org> <1158762221.6512.10.camel@Homer.simpson.net>
In-Reply-To: <1158762221.6512.10.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609201518.22798.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 20 September 2006 16:23, Mike Galbraith wrote:
> On Tue, 2006-09-19 at 13:36 -0700, Andrew Morton wrote:
> > On Tue, 19 Sep 2006 22:25:21 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > > - It took maybe ten hours solid work to get this dogpile vaguely
> > > >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> > > >   I guess it's worth briefly testing if you're keen.
> > > 
> > > It's not that bad, but unfortunately the networking doesn't work on my system
> > > (HPC nx6325 + SUSE 10.1 w/ updates, 64-bit).  Apparently, the interfaces don't
> > > get configured (both tg3 and bcm43xx are affected).
> > 
> > Is there anything interesting in the dmesg output?
> > 
> > Perhaps an `strace -f ifup' or whatever would tell us what's failing.
> 
> FYI, it`s SuSE`s /sbin/getcfg binary that doesn't like the changes.  It
> sees /sys/class/net/eth0 as a symlink, and reels off into sys/block (?)
> looking for a directory.

I have filed a report in the SUSE bugzilla.  Let's see what happens.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
