Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUEXI1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUEXI1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUEXI1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:27:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:25750 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263365AbUEXI1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:27:11 -0400
Date: Mon, 24 May 2004 10:27:09 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, arnd@arndb.de, drepper@redhat.com,
       linux-kernel@vger.kernel.org, mingo@redhat.com, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040524082709.GA3728@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
	arnd@arndb.de, drepper@redhat.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, schwidefsky@de.ibm.com
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com> <20040524011203.3be81d0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524011203.3be81d0a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 01:12:03AM -0700, Andrew Morton wrote:
> Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > That said, NPTL can deal with any of these variants and the decision
> >  is up to Martin I think (assuming the base patch gets accepted, that is).
> 
> Well the race is real and does need a kernel fix, so I queued it up.  I
> guess if the new argument to sys_futex() breaks some architecture they can
> independently add a new syscall for it, or send a fix.  Mutter.
> 
> It's a bit of a shame that you need to be a rocket scientist to 
> understand the futex syscall interface.  Bert, are you still maintaining
> the manpage?  If so, is there enough info here to update it?

I'll spend some time with the manpage tomorrow. Some other comments have
been queued too and I'll process them. By that time, I'll hand over the
manpages to aeb.

Thanks for the heads up.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
