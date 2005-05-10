Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVEJUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVEJUxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEJUxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:53:39 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:16303 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261785AbVEJUwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:52:44 -0400
Date: Tue, 10 May 2005 13:52:39 -0700
From: Greg KH <gregkh@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510205239.GA3634@suse.de>
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510203156.GA14979@wonderland.linux.it>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 10:31:56PM +0200, Marco d'Itri wrote:
> On May 10, Greg KH <gregkh@suse.de> wrote:
> 
> > > > Why not this or something similar (e.g. I want to blacklist the xxx and 
> > > > yyy modules)? (note, untested)
> > Nice, I like it.
> But it does not work.

Why not?

> > > Because it's impossible to predict how it will interact with other
> > > install and alias commands.
> > Then we will just have to find out :)
> It should be clear that it will interact badly with another install
> commands, with one of them being ignored. This is not acceptable.

Why?  Will they not all just be checked in order?

> > > A less fundamental but still major problem is that this would be a
> > > different API, and both users and packages have been aware of
> > > /etc/hotplug/blacklist* for a long time now.
> > And as /etc/hotplug/* is going away for hotplug-ng, I don't think this
> > is going to be an issue.  Also, the blacklisting stuff should not be
> > that prevelant anymore...
> It's a feature which I know my users and other maintainers need
> (for duplicated drivers, OSS drivers, watchdog drivers, usb{mouse,kbd}
> and so on) so it's a prerequisite for the successful packaging of
> hotplug-ng.

Ok, then, care to make a patch to module-init-tools to provide this
functionality?

thanks,

greg k-h
