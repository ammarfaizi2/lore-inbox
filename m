Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWFVGgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWFVGgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWFVGgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:36:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:64976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030617AbWFVGgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:36:37 -0400
Date: Wed, 21 Jun 2006 23:09:09 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, geert@linux-m68k.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-ID: <20060622060909.GA15834@kroah.com>
References: <20060621172903.GC9423@in.ibm.com> <20060621132227.ec401f93.akpm@osdl.org> <20060621204120.GA14739@in.ibm.com> <20060621135855.ce68720f.akpm@osdl.org> <20060621231552.GA25514@in.ibm.com> <20060621162715.4d91ff05.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621162715.4d91ff05.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 04:27:15PM -0700, Andrew Morton wrote:
> On Wed, 21 Jun 2006 19:15:52 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > On Wed, Jun 21, 2006 at 01:58:55PM -0700, Andrew Morton wrote:
> > > > 
> > > > Andrew, you don't have to apply this patch. It is supposed to be picked
> > > > by Greg.
> > > > 
> > > > There seems to be some confusion. Just few days back Greg consolidated
> > > > and re-organized all the 64bit resources patches and posted on LKML for
> > > > review.
> > > > 
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> > > > 
> > > > There were few review comments regarding kconfig options.
> > > > I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> > > > CONFIG_RESOURCES_64BIT.
> > > > 
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> > > > 
> > > > Now Greg's tree and your tree are not exact replica when it comes to 
> > > > 64bit resource patches. Hence this patch is supposed to be picked by 
> > > > Greg to make sure things are not broken in his tree.
> > > 
> > > I'm working against Greg's tree, always...
> > 
> > I am sorry. That's a mistake on my part. I misunderstood it.
> 
> Oh.
> 
> > Can you please include the attached patch.
> 
> Hopefully I'll pick it up from
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci
> later today?

It will be tomorrow, sorry, catching up on other merge stuff...

thanks,

greg k-h
