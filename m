Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUJEUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUJEUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJEUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:47:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:31954 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265234AbUJEUr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:47:56 -0400
Date: Tue, 5 Oct 2004 22:55:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Johnson, Richard" <rjohnson@analogic.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
In-Reply-To: <Pine.LNX.4.53.0410051635370.3240@quark.analogic.com>
Message-ID: <Pine.LNX.4.61.0410052247140.2913@dragon.hygekrogen.localhost>
References: <1097004565.9975.25.camel@laptop.fenrus.com>
 <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0410051635370.3240@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Johnson, Richard wrote:

> On Tue, 5 Oct 2004, Jesper Juhl wrote:
> 
> > On Tue, 5 Oct 2004, Arjan van de Ven wrote:
> >
> > > If Richard overwrote his modules anyway he must have hacked the Makefile
> > > himself to deliberately cause this, at which point... well saw wind
> > > harvest storm ;)
> > >
> > While I lack specific Fedora knowledge and thus can't provide exact
> > details for it I'd say it should still be pretty simple to recover. On
> > Slackware I'd simply boot a kernel from the install CD and tell it to
> > mount the installed system on my HD, then you'll have a running system and
> > can easily clean out the broken modules etc and install the original ones
> > from your CD and be right back where you started in 5 min. Surely
> > something similar is possible with Fedora, reinstalling from scratch (as
> > he said he did) seems like massive overkill to me.
> >
> 
> Yeh?  There is no place to get replacement modules from. They are
> somewhere on some RPM on one of the CDs,

That's not what I'd call "no place", that's "a place", and one you most 
likely have available lying on your desk. Even if you don't have the CDs 
any more you can always download the RPM you need from the net while 
running in rescue mode.

> with no way to know. It's
> not like you could tar everything from the current root file-system.
> 
Just like Slackware has a log of all packages and the files they contain 
in /var/log/packages/ , so does RPM based distros like Fedora have their 
rpm database. The 'rpm' tool can be used to search the database for 
packages that contain a specific file, and once you know the RPM you need 
you can easily find it on your CDs (even if you have no idea where to look 
'find' should find it for you easily enough). Read through "man rpm" some 
day, a package tool without a database of installed packages and the 
files contained in those packages would be pretty useless.


--
Jesper Juhl

