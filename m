Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUFDSoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUFDSoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUFDSoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:44:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:50114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265946AbUFDSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:43:47 -0400
Date: Fri, 4 Jun 2004 11:42:52 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
Message-ID: <20040604184252.GA11804@kroah.com>
References: <10857795552653@kroah.com> <10857795552130@kroah.com> <20040604122518.GB11950@elf.ucw.cz> <20040604162643.GB9342@kroah.com> <20040604182559.GI700@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604182559.GI700@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 08:26:00PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > [PATCH] Report which device failed to suspend
> > > > 
> > > > Based on a patch from Nickolai Zeldovich <kolya@MIT.EDU> but put into the
> > > > proper place by me.
> > > 
> > > Seems good.
> > > 
> > > I'm seeing lots of problems with drivers & swsusp these days. Perhaps
> > > even printing names of devices as they are suspended is good idea?
> > 
> > You mean like the current kernel tree does if you enable
> > CONFIG_DEBUG_DRIVER?  :)
> 
> Well, something little less verbose but enabled by default would do
> the trick.

I don't think the current one is all that verbose, it just prints out
one line for every device being suspended.  And if a user is having
problems, it's quite easy to ask them to enable that option and send the
output from a failed suspend.

But if you have a patch to change it, please send it.

thanks,

greg k-h


> 								Pavel
> -- 
> 934a471f20d6580d5aad759bf0d97ddc
