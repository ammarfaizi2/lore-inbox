Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVD3GLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVD3GLK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVD3GLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 02:11:09 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:34925 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262524AbVD3GK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 02:10:58 -0400
Date: Fri, 29 Apr 2005 22:10:31 -0700
From: Greg KH <gregkh@suse.de>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO etc.
Message-ID: <20050430051030.GA10005@suse.de>
References: <20050427171446.GA3195@kroah.com> <20050427171649.GG3195@kroah.com> <1114619928.18809.118.camel@localhost.localdomain> <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local> <1114694511.18809.187.camel@localhost.localdomain> <20050429042014.GC25474@kroah.com> <1114805784.18330.297.camel@localhost.localdomain> <20050429203805.GA2959@kroah.com> <Pine.LNX.4.61.0504300849350.21122@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504300849350.21122@kai.makisara.local>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 08:52:31AM +0300, Kai Makisara wrote:
> On Fri, 29 Apr 2005, Greg KH wrote:
> 
> > On Fri, Apr 29, 2005 at 09:16:27PM +0100, Alan Cox wrote:
> > > On Gwe, 2005-04-29 at 05:20, Greg KH wrote:
> > > > > Ok thats the bit I needed to know
> > > > 
> > > > So, do you still object to this patch being accepted?
> > > 
> > > Switched to CAP_SYS_RAWIO I don't. Its the wrong answer long term I
> > > suspect but its definitely a good answer for now.
> > 
> > Switch it in both capable() calls in the patch?  Kai, is this acceptable
> > to you also?
> > 
> Yes. Using CAP_SYS_ADMIN here was wrong.

Ok, care to send a new patch that I can use for the next -stable kernel
release?

thanks,

greg k-h
