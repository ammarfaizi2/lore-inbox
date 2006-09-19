Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWISWc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWISWc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWISWc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:32:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:30610 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751266AbWISWc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:32:26 -0400
Date: Tue, 19 Sep 2006 15:30:15 -0700
From: Greg KH <greg@kroah.com>
To: David Miller <davem@davemloft.net>
Cc: rjw@sisk.pl, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
Message-ID: <20060919223015.GA23088@kroah.com>
References: <20060919133606.f0c92e66.akpm@osdl.org> <200609192330.34769.rjw@sisk.pl> <200609200006.53138.rjw@sisk.pl> <20060919.150629.109607267.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919.150629.109607267.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 03:06:29PM -0700, David Miller wrote:
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> Date: Wed, 20 Sep 2006 00:06:52 +0200
> 
> > I _guess_ the problem is caused by
> > gregkh-driver-network-class_device-to-device.patch, but I can't verify this,
> > because the kernel (obviously) doesn't compile if I revert it.
> 
> Indeed.
> 
> I thought we threw this patch out because we knew it would cause
> problems for existing systems?  I do remember Greg making an argument
> as to why we needed the change, but that doesn't make breaking people's
> systems legitimate in any way.

It's now thrown out, and I think Andrew already had a patch in his tree
that reverted this.

I'll be bringing it back eventually, but first we are going to work out
all the kinks by probably putting these changes in the next few SuSE
alpha releases to see what shakes out in userspace that we need to go
fix.

It's not 2.6.19 material at all, so don't worry :)

thanks,

greg k-h
