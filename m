Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTJ1Tld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTJ1Tld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:41:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:7885 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261639AbTJ1Tlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:41:31 -0500
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
From: John Cherry <cherry@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Mark Bellon <mbellon@mvista.com>, Pat Mochel <mochel@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net, cgl_discussion@osdl.org
In-Reply-To: <20031028181707.GA7225@kroah.com>
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise>
	 <3F9DA5A6.3020008@mvista.com> <20031027233934.GA3408@kroah.com>
	 <3F9EABC1.9070009@mvista.com>  <20031028181707.GA7225@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067370055.27022.29.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Oct 2003 11:40:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The requirements were collected from the OSDL CGL requirements 
> > specification version 1.0 and 1.1 ratified September 2002. They come 
> > from extensive discussions with the OSDL members as part of the 
> > definition of these requirements, expounding on them:
> 
> Wait, all the Carrier Grade Linux Requirement Definition Version 2.0 say
> about "Persistent Device Naming" is the following:
> 
> 	OSDL CGL specifies that carrier grade Linux shall provide
> 	functionality such that a device's identity shall be maintained
> 	when it is removed and reinstalled even if it is plugged into a
> 	different bus, slot, or adapter.  "Device identity" is the name
> 	of the device presented to user space, and this identity is
> 	assigned based on policies set by the administrator, e.g., based
> 	on location or hardware identification information.

Thanks for point out the actual CGL requirement, Greg. 


> > The two packages take philosophically different approaches and arrive 
> > with (largely) overlapping and some non-overlapping capabilities - after 
> > all they are both trying to do "the same thing". The uSDE has strengths 
> > and weaknesses just as udev or any program does. It is certainly 
> > possible to discuss changes (and make patches) to udev to incorporate 
> > the key issues addressed in the uSDE implementation.
> 
> Besides the refusal to handle network devices, I don't see any thing
> that udev is lacking that uSDE has.  But I'm not too familar with uSDE,
> being that it has only been released for a few days now.  If you could
> point out anything that udev is lacking, I would be glad to help solve
> that.
> 

The Carrier Grade Linux specification has never dictated an
implementation.  In fact, both udev and uSDE are listed as potential
implementations.

As Lars stated in an earlier email, "Competition is good, but only if
they explore distinct approaches".  It is a shame that much effort has
been duplicated here on similar approaches.  I'm not fully aware of the
history behind the divergence, but it makes sense to enumerate NOW what
is lacking in udev from a uSDE perspective.  One objective of the
carrier grade initiative is to prevent duplicate effort.  Now that we
have two implementations, let's get the issues/differences on the table
and cooperatively move to convergence.

John

