Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVF3G3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVF3G3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVF3G3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:29:19 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:20060 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262865AbVF3G1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:27:37 -0400
Date: Wed, 29 Jun 2005 23:27:32 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PATCH] Driver core patches for 2.6.13-rc1
Message-ID: <20050630062732.GA23657@suse.de>
References: <20050630060206.GA23321@kroah.com> <200506300119.27306.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300119.27306.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 01:19:26AM -0500, Dmitry Torokhov wrote:
> On Thursday 30 June 2005 01:02, Greg KH wrote:
> > Here are some small patches for the driver core.  They fix a bug that
> > has caused some people to see deadlocks when some drivers are unloaded
> > (like ieee1394), and add the ability to bind and unbind drivers from
> > devices from userspace (something that people have been asking for for a
> > long time.)
> > 
> 
> Please don't until all buses are either audited or prepared to handle
> "surprise" disconnects.

That's what bugfixes after 2.6.13-rc2 are for :)

Seriously, I don't think this is a big deal.  But I will work with you
on getting any remaining issues you have solved.  For now, the patches
should stay for their usefulness to others.  I'll continue this
conversation in the other thread about the bind/unbind stuff.

thanks,

greg k-h
