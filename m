Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVBLACy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVBLACy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVBLACy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:02:54 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:33805 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262289AbVBLACw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:02:52 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Kasper Sandberg <lkml@metanurb.dk>
To: Greg KH <gregkh@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050211170640.GB16074@suse.de>
References: <20050211004033.GA26624@suse.de>
	 <20050211005258.GB26890@kroah.com> <1108085445.12935.0.camel@localhost>
	 <1108104083.32129.0.camel@localhost.localdomain>
	 <1108122427.12911.0.camel@localhost>  <20050211170640.GB16074@suse.de>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 01:02:48 +0100
Message-Id: <1108166569.14669.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 09:06 -0800, Greg KH wrote:
> On Fri, Feb 11, 2005 at 12:47:07PM +0100, Kasper Sandberg wrote:
> > On Thu, 2005-02-10 at 22:41 -0800, Greg KH wrote:
> > > On Fri, 2005-02-11 at 02:30 +0100, Kasper Sandberg wrote:
> > > > hey greg
> > > > 
> > > > i remember for some months back, you posted something similar.. is this
> > > > a version thats ready for use? if it is! im gonna use it! :D
> > > 
> > > Yes, this is that version, cleaned up and given a proper build system,
> > > and even tested on my machines here :)
> > ah cool. and in that case, you probably also have ebuilds for it, if you
> > do, please post them somewhere :)
> 
> I don't have an ebuild for it yet, but it's on my list to get done.  And
> when I do so, it will just show up in the normal gentoo tree.  The main
> "issue" with this is I need to create a virtual for the hotplug service
> so it doesn't conflict with the existing hotplug package.  Not a big
> deal, just not as simple as adding a single ebuild to the tree.
just make it provide virtual/hotplug, then do a fgrep -r
"hotplug" /usr/portage/ and then replace with virtual/hotplug ;)
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

