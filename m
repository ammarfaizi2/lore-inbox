Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317805AbSGVVLc>; Mon, 22 Jul 2002 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317807AbSGVVLc>; Mon, 22 Jul 2002 17:11:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14133 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317805AbSGVVLa>; Mon, 22 Jul 2002 17:11:30 -0400
Date: Mon, 22 Jul 2002 17:14:38 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27: s390 fixes.
Message-ID: <20020722171438.A11295@devserv.devel.redhat.com>
References: <mailman.1027363500.9793.linux-kernel2news@redhat.com> <200207222100.g6ML0UN08293@devserv.devel.redhat.com> <20020722220413.A12952@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722220413.A12952@infradead.org>; from hch@infradead.org on Mon, Jul 22, 2002 at 10:04:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 22 Jul 2002 22:04:13 +0100
> From: Christoph Hellwig <hch@infradead.org>

> > > * add sys_security system call
> > 
> > I do not see the body of the call in the attached patch.
> 
> Does need to.  Is yet another magic dispatcher that has randomly changing
> behaviour depending on the linux crap^H^H^H^Hsecurity module loaded.

I just realized that it comes from the LSM. Sorry.

Why does it need to be added into the architecture and
not kept together with the patch-2.5.27-lsm1.gz or such?
I am afraid that precludes compilation of architectures
without LSM applied.

-- Pete
