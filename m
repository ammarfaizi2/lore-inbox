Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317835AbSGVVX5>; Mon, 22 Jul 2002 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGVVX5>; Mon, 22 Jul 2002 17:23:57 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:62735 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317835AbSGVVX4>;
	Mon, 22 Jul 2002 17:23:56 -0400
Date: Mon, 22 Jul 2002 14:24:56 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27: s390 fixes.
Message-ID: <20020722212456.GA12291@kroah.com>
References: <mailman.1027363500.9793.linux-kernel2news@redhat.com> <200207222100.g6ML0UN08293@devserv.devel.redhat.com> <20020722220413.A12952@infradead.org> <20020722171438.A11295@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020722171438.A11295@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 20:21:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 05:14:38PM -0400, Pete Zaitcev wrote:
> > Date: Mon, 22 Jul 2002 22:04:13 +0100
> > From: Christoph Hellwig <hch@infradead.org>
> 
> > > > * add sys_security system call
> > > 
> > > I do not see the body of the call in the attached patch.
> > 
> > Does need to.  Is yet another magic dispatcher that has randomly changing
> > behaviour depending on the linux crap^H^H^H^Hsecurity module loaded.
> 
> I just realized that it comes from the LSM. Sorry.
> 
> Why does it need to be added into the architecture and
> not kept together with the patch-2.5.27-lsm1.gz or such?
> I am afraid that precludes compilation of architectures
> without LSM applied.

Because the LSM framework is now in the kernel, including sys_security.

thanks,

greg k-h
