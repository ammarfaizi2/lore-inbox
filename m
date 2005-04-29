Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVD2UrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVD2UrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVD2Uqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:46:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:16350 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262953AbVD2Uor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:44:47 -0400
Date: Fri, 29 Apr 2005 13:38:05 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO etc.
Message-ID: <20050429203805.GA2959@kroah.com>
References: <20050427171446.GA3195@kroah.com> <20050427171649.GG3195@kroah.com> <1114619928.18809.118.camel@localhost.localdomain> <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local> <1114694511.18809.187.camel@localhost.localdomain> <20050429042014.GC25474@kroah.com> <1114805784.18330.297.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114805784.18330.297.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 09:16:27PM +0100, Alan Cox wrote:
> On Gwe, 2005-04-29 at 05:20, Greg KH wrote:
> > > Ok thats the bit I needed to know
> > 
> > So, do you still object to this patch being accepted?
> 
> Switched to CAP_SYS_RAWIO I don't. Its the wrong answer long term I
> suspect but its definitely a good answer for now.

Switch it in both capable() calls in the patch?  Kai, is this acceptable
to you also?

thanks,

greg k-h
