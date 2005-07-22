Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVGVFGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVGVFGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGVFGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:06:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30343 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262037AbVGVFEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:04:21 -0400
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-reply-to: Your message of Fri, 22 Jul 2005 00:53:58 EDT.
             <Pine.LNX.4.44.0507220033371.4935-100000@coffee.psychology.mcmaster.ca> 
Date: Thu, 21 Jul 2005 22:03:29 -0700
Message-Id: <E1Dvph3-00087R-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005 00:53:58 EDT, Mark Hahn wrote:
> > > > yes, that's the crux.  CKRM is all about resolving conflicting resource 
> > > > demands in a multi-user, multi-server, multi-purpose machine.  this is a 
> > > > huge undertaking, and I'd argue that it's completely inappropriate for 
> > > > *most* servers.  that is, computers are generally so damn cheap that 
> > > > the clear trend is towards dedicating a machine to a specific purpose, 
> > > > rather than running eg, shell/MUA/MTA/FS/DB/etc all on a single machine.  
> >  
> > This is a big NAK - if computers are so damn cheap, why is virtualization
> > and consolidation such a big deal?  Well, the answer is actually that
> 
> yes, you did miss my point.  I'm actually arguing that it's bad design
> to attempt to arbitrate within a single shared user-space.  you make 
> the fast path slower and less maintainable.  if you are really concerned
> about isolating many competing servers on a single piece of hardware, then
> run separate virtualized environments, each with its own user-space.

I'm willing to agree to disagree.  I'm in favor of full virtualization
as well, as it is appropriate to certain styles of workloads.  I also
have enough end users who also want to share user level, share tasks,
yet also have some level of balancing between the resource consumption
of the various environments.  I don't think you are one of those end
users, though.  I don't think I'm required to make everyone happy all
the time.  ;)

BTW, does your mailer purposefully remove cc:'s?  Seems like that is
normally considered impolite.

gerrit
