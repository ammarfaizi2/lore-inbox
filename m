Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUEADzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUEADzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUEADzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:55:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:11992 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbUEADzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:55:15 -0400
Date: Fri, 30 Apr 2004 18:55:49 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Cherry <cherry@osdl.org>, Scott Murray <scottm@somanetworks.com>,
       eike-hotplug@sf-tec.de, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm1 (compile stats)
Message-ID: <20040501015549.GC16006@kroah.com>
References: <20040430014658.112a6181.akpm@osdl.org> <1083342188.671.9.camel@cherrypit.pdx.osdl.net> <20040430223928.GA2541@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430223928.GA2541@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 12:39:28AM +0200, Adrian Bunk wrote:
> On Fri, Apr 30, 2004 at 09:23:08AM -0700, John Cherry wrote:
> > Just one new error in the allyesconfig and allmodconfig builds.
> > 
> >   CC      drivers/pci/hotplug/cpci_hotplug_core.o
> > drivers/pci/hotplug/cpci_hotplug_core.c: In function
> > `slot_paranoia_check':
> > drivers/pci/hotplug/cpci_hotplug_core.c:97: structure has no member
> > named `magic'
> > drivers/pci/hotplug/cpci_hotplug_core.c:97: `SLOT_MAGIC' undeclared
> > (first use in this function)
> > drivers/pci/hotplug/cpci_hotplug_core.c:97: (Each undeclared identifier
> > is reported only once
> > drivers/pci/hotplug/cpci_hotplug_core.c:97: for each function it appears
> > in.)
> >   CC      drivers/net/tulip/21142.o
> > make[3]: [drivers/pci/hotplug/cpci_hotplug_core.o] Error 1
> >...
> 
> It seems cpci_hotplug_core.c was forgotten when some changes were made 
> that are in bk-pci...

Already fixed, thanks.

greg k-h
