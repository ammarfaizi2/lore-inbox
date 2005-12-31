Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVLaATc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLaATc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVLaATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:19:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:18412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751183AbVLaATH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:19:07 -0500
Date: Fri, 30 Dec 2005 16:10:51 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
Message-ID: <20051231001051.GB20314@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <20051230080002.GA7438@kroah.com> <1135984304.13318.50.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135984304.13318.50.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:11:44PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 00:00 -0800, Greg KH wrote:
> > >   - The driver still uses EXPORT_SYMBOL, for consistency with other
> > >     code in drivers/infiniband
> > 
> > Why would that matter?
> 
> I don't want to do something gratuitously different to the prevailing
> set of code in which it lives.
> 
> > >   - We're still using ioctls instead of sysfs or configfs in some
> > >     cases, to maintain userspace compatibility
> > 
> > Compatibility with what?  The driver isn't in the kernel tree yet, so
> > there's no old kernel versions to remain compatibile with :)
> 
> We already ship userspace code to customers that relies on the ioctl
> interfaces.

But we (the kernel community), don't really accept that as a valid
reason to accept this kind of code, sorry.

Why not just update your userspace code and ship that out to your
customers, as you know exactly who they are due to the lack of the
driver in the mainline kernel tree :)

thanks,

greg k-h
