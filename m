Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVF1VwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVF1VwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVF1Vub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:50:31 -0400
Received: from email.msoe.edu ([155.92.194.61]:40293 "EHLO email.msoe.edu")
	by vger.kernel.org with ESMTP id S261300AbVF1VtO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:49:14 -0400
Subject: Re: reiser4 plugins
From: Jake Maciejewski <maciejej@msoe.edu>
To: Markus =?ISO-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20050628204709.GH11013@nysv.org>
References: <20050627092138.GD11013@nysv.org>
	 <200506281344.j5SDixiH003441@laptop11.inf.utfsm.cl>
	 <20050628204709.GH11013@nysv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 28 Jun 2005 16:48:26 -0500
Message-Id: <1119995306.18003.33.camel@gentoo>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 28 Jun 2005 21:49:13.0979 (UTC) FILETIME=[397BF4B0:01C57C2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 23:47 +0300, Markus Törnqvist wrote:
> On Tue, Jun 28, 2005 at 09:44:59AM -0400, Horst von Brand wrote:
> >
> >No. But just relying on perfect hardware and concientious sysadmins is
> >reckless. Hardware /is/ flaky, sysadmins /are/ (sometimes) lazy (and
> >besides, today they are increasingly just plain Joe Sixpack users). Also,
> >backing up a few hundred GiB is /not/ fun, and then keeping track of all
> >the backups is messy.
> 
> Even home users have started to set up raid mirrors at home now that
> disk space is cheap. That's a step in the right direction, I
> suppose, with hardware never being good.

I've lost more data to my own recklessness and stupidity than filesystem
corruption and hardware failure combined. RAID isn't really a good
solution. My policy for cheap storage (currently the only variety I own)
is when I buy a new hard drive, use the old drive for backups. The old
drive is always large enough to hold everything I'd miss and then some.
Home users should be capable of doing the same, assuming Windows has
something similar to rsync.

> 
> Taking backups in an environment where you need a few hundred GiB
> backed up is not that difficult.
> 
> Get a separate, redundant box with a big tape changer and drop
> periodical backups off at your bank's vault.
> 
> Get a separate, very reduntant box, with a truckload of proven 
> drives in a separate raid box and run your stuff there.
> 
> Get both of the above.
> 
> If Joe Sixpack loses his mp3 collection, I don't really care,
> nor should anyone else. Anything important enough to care
> about is easy enough to back up. Always.
> 
> Arrogance? Maybe.
> 
> >Also, I'm not claiming that they are /solely/ responsible, but not having
> >the filesystem fall apart utterly every time some bug breaths on it /is/ a
> >requirement.
> 
> Reiserfs does not fall apart utterly every time some bug breaths on it.
> 
> >> *still trying to understand how that can be*
> >You haven't been around too much yet, do you?
> 
> Rather I take backups, buy better hardware and understand there's a
> risk involved.
> 
> Computers as a complete set can't be trusted, you can only make
> the best accomodations you can.
> 
-- 
Jake Maciejewski <maciejej@msoe.edu>

