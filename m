Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVC2B2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVC2B2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVC2B2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:28:33 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1268 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262115AbVC2B2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:28:06 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: floam@sh.nu, LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org,
       vonbrand@inf.utfsm.cl, bunk@stusta.de
In-Reply-To: <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
	 <1112011441.27381.31.camel@localhost.localdomain>
	 <1112016850.6003.13.camel@laptopd505.fenrus.org>
	 <1112018265.27381.63.camel@localhost.localdomain>
	 <20050328154338.753f27e3.pj@engr.sgi.com>
	 <1112055671.3691.8.camel@localhost.localdomain>
	 <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 28 Mar 2005 20:27:21 -0500
Message-Id: <1112059642.3691.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 19:56 -0500, Kyle Moffett wrote:
> On Mar 28, 2005, at 19:21, Steven Rostedt wrote:
> > So you are saying that a stand alone section of code, that needs
> > wrappers to work with Linux is a derived work of Linux? If there's
> > some functionality, that you make, and it just happens to need
> > some kind of operating system to work. Does that make it a derived
> > work of any operating system?
> 
> It depends on how special and different the wrappers for Linux are
> from the wrappers for other operating systems.  Like, for example,
> the sysfs stuff is so radically different from the APIs that other
> operating systems provide that anything using it is most likely
> copied from other in-kernel sysfs code, and is therefore derived
> from the Linux kernel.
> 

If your stand alone code has it's own API and your GPL wrapper handles
the sysfs interface, then this might get around it.

> > OK, I took your advise and found this from googling:
> >
> > http://www.pbwt.com/Attorney/files/ravicher_1.pdf
> 
> Mmm, good reference, thanks!
> 

You're welcome!

> > Unless you misunderstood me, and thought that I was talking
> > about taking some part of Linux and making it work under another
> > OS, I still stand by my statement.
> 
> I think it really depends on the APIs implemented.  Anything based
> on the sysfs code, even if only using the APIs, will probably be
> found to be a derivative work (NOTE: IANAL) because the sysfs API
> is so very different from everything else.  Other interfaces like
> PCI management, memory management, etc, may not be so protectable,
> because they are standard across many systems.  If Linux got a
> new and unique memory hotplug API, however, that might be a very
> different story.  Similar things could be said about integration
> between drivers and the new Unified Driver Model, which appears to
> be quite original.
> 

Yes, but as the article states, ideas are not protected under copyright
law. So an unique idea to handle hotplug then it may still not be
covered.  This is all very ambiguous, and is too confusing. I'll leave
it up to the lawers!

-- Steve

