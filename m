Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWITWlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWITWlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWITWlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:41:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:25514 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932430AbWITWlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:41:18 -0400
Date: Wed, 20 Sep 2006 15:41:10 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-kernel@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB: fix autosuspend-autoresume with CONFIGRe: 2.6.19 -mm merge plans
Message-ID: <20060920224110.GA15519@kroah.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <Pine.LNX.4.64.0609202345590.13974@twin.jikos.cz> <20060920150918.abe0288d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920150918.abe0288d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 03:09:18PM -0700, Andrew Morton wrote:
> On Wed, 20 Sep 2006 23:53:23 +0200 (CEST)
> Jiri Kosina <jikos@jikos.cz> wrote:
> 
> > On Wed, 20 Sep 2006, Andrew Morton wrote:
> > 
> > > fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
> > > gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
> > 
> > Hi Andrew,
> > 
> > a few days ago I submitted a patch [1] to autosupend-autoresume 
> > infrastructure (and Alan Stern submitted a similar patch a few hours later 
> > [2]). 
> > 
> > Without this one-liner, all kernels compiled without CONFIG_USB_SUSPEND 
> > will be unable to perform more than one suspend/resume cycle, which is 
> > quite annoying. Would you please reconsider pushing these together with 
> > other autosuspend/autoresume infrastructure fixes?
> > 
> > Thanks.
> > 
> > [1] http://lkml.org/lkml/2006/9/18/290
> > [2] http://lkml.org/lkml/2006/9/19/93
> 
> I expect the appropriate fixes will automagically appear in Greg's tree, to
> be picked up in next -mm.  Perhaps they already have appeared - Alan?

I just added the fix to my tree, am catching up on my pending patch
queue right now...

thanks,

greg k-h
