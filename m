Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUGWVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUGWVeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUGWVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:34:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47986 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268081AbUGWVem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:34:42 -0400
Date: Sat, 24 Jul 2004 01:35:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]: CONFIG_UNSUPPORTED (was: Re: [PATCH] delete devfs)
Message-ID: <20040723233533.GA19808@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	"R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org
References: <20040721141524.GA12564@kroah.com> <20040722064952.GC20561@kroah.com> <20040722091335.A17187@home.com> <200407232106.41065.rjwysocki@sisk.pl> <20040723200416.GO19329@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723200416.GO19329@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 10:04:17PM +0200, Adrian Bunk wrote:
> On Fri, Jul 23, 2004 at 09:06:40PM +0200, R. J. Wysocki wrote:
> 
> >...
> > 2. Proposal
> > 
> > I propose to introduce a new configuration option CONFIG_UNSUPPORTED, such 
> > that if it is not set, the unmaintained/unsupported code will not be compiled 
> > into the kernel.  Moreover,
> > * IMO the option should not be set by default, which would require a user 
> > action to include the unsupported code into the kernel,
> > * IMO the option should be documented as to indicate that the code marked with 
> > the help of it is not supported by kernel developers and may be removed from 
> > the kernel at any time without notification.
> >...
> 
> Quoting 2.6 MAINTAINERS:
> 
> <--  snip  -->
> 
> PCMCIA SUBSYSTEM
> L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> S:      Unmaintained
> 
> <--  snip  -->

Stuff is marked OBSOLETE in Kconfig files, and text for menu option is
reflecting this.
This can well be overlooed if one does 'make oldconfig' only,
but at least documented this way.

	Sam
