Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUG1QiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUG1QiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUG1QiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:38:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267302AbUG1QgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:36:07 -0400
Date: Wed, 28 Jul 2004 18:33:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040728163353.GJ10377@suse.de>
References: <1090989052.3098.6.camel@camp4.serpentine.com> <20040728053107.GB11690@suse.de> <c93051e8040727235123a6ed67@mail.gmail.com> <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com> <20040728145543.GB18846@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728145543.GB18846@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28 2004, Arjan van de Ven wrote:
> On Wed, Jul 28, 2004 at 03:52:28PM +0100, Dave Jones wrote:
> > On Wed, Jul 28, 2004 at 08:53:19AM +0200, Jens Axboe wrote:
> >  > On Wed, Jul 28 2004, Edward Angelo Dayao wrote:
> >  > > yeah i get this kind of error in my logs as well from my liteon
> >  > > dvd-rom at home. thats like 6 months old and happened on fc2 when i
> >  > > had that installed on it. haven't noticed anything on mandrake 10 (the
> >  > > current distro i use at home) with 2.6.7.
> >  > > 
> >  > > i got the same error on my old notebook, a compaq presario... that was
> >  > > prior to the drive being sent to that big junk yard in the sky.  i
> >  > > forget what model that was.  but i was running then...  rh9.
> >  > > 
> >  > > hope this bit helps guys resolve this. 
> >  > 
> >  > (dont top post!)
> >  > 
> >  > Sounds like something fc2 is doing, I'd suggest filing a bug report with
> >  > them.
> > 
> > Curious. The relevant code should match mainline 1:1 there unless I'm
> > mistaken. Arjan ?
> 
> we don't patch the ide layer, ide-cd or isofs... so really curious.

I meant that something from userspace is triggering these errors, it's
not necessarily a kernel issue.

-- 
Jens Axboe

