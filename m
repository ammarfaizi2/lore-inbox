Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUD3Wjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUD3Wjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUD3Wjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:39:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:63184 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261661AbUD3Wjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:39:31 -0400
Date: Fri, 30 Apr 2004 15:37:23 -0700
From: Greg KH <greg@kroah.com>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm1 (compile stats)
Message-ID: <20040430223723.GA14535@kroah.com>
References: <20040430014658.112a6181.akpm@osdl.org> <1083342188.671.9.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083342188.671.9.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 09:23:08AM -0700, John Cherry wrote:
> Just one new error in the allyesconfig and allmodconfig builds.
> 
>   CC      drivers/pci/hotplug/cpci_hotplug_core.o
> drivers/pci/hotplug/cpci_hotplug_core.c: In function
> `slot_paranoia_check':
> drivers/pci/hotplug/cpci_hotplug_core.c:97: structure has no member
> named `magic'
> drivers/pci/hotplug/cpci_hotplug_core.c:97: `SLOT_MAGIC' undeclared
> (first use in this function)
> drivers/pci/hotplug/cpci_hotplug_core.c:97: (Each undeclared identifier
> is reported only once
> drivers/pci/hotplug/cpci_hotplug_core.c:97: for each function it appears
> in.)
> make[3]: [drivers/pci/hotplug/cpci_hotplug_core.o] Error 1

Known issue, is now fixed.  My bk-pci tree was at a intermediate state
when this -mm tree was created (my fault...)

thanks,

greg k-h
