Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUIPEI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUIPEI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUIPEI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:08:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:49563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267455AbUIPEIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:08:54 -0400
Date: Wed, 15 Sep 2004 21:08:21 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>, Tim Hockin <thockin@hockin.org>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040916040820.GA5395@kroah.com>
References: <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <20040915213419.GA21899@hockin.org> <1095284320.23385.123.camel@betsy.boston.ximian.com> <20040916012104.GA21832@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916012104.GA21832@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 03:21:04AM +0200, Herbert Poetzl wrote:
> On Wed, Sep 15, 2004 at 05:38:39PM -0400, Robert Love wrote:
> > On Wed, 2004-09-15 at 14:34 -0700, Tim Hockin wrote:
> > 
> > > It's a can of worms, is what it is.  And I'm not sure what a good fix
> > > would be.  Would it just be enough to send a generic "mount-table changed"
> > > event, and let userspace figure out the rest?
> > 
> > "Can of worms" is a tough description for something that there is no
> > practical security issue for, just a lot of hand waving.  No one even
> > uses name spaces.
> 
> ah, sorry, that is wrong, we (linux-vserver)
> _do_ use namespaces extensively, and probably 
> other 'jail' solutions will use it too ...

Great.  So, how do you handle the /sbin/hotplug call today?  How would
you want to handle this kevent notifier?

thanks,

greg k-h
