Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUD3Wjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUD3Wjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUD3Wjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:39:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38618 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261724AbUD3Wjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:39:37 -0400
Date: Sat, 1 May 2004 00:39:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>, Scott Murray <scottm@somanetworks.com>,
       Greg KH <greg@kroah.com>, eike-hotplug@sf-tec.de
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm1 (compile stats)
Message-ID: <20040430223928.GA2541@fs.tum.de>
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
>   CC      drivers/net/tulip/21142.o
> make[3]: [drivers/pci/hotplug/cpci_hotplug_core.o] Error 1
>...

It seems cpci_hotplug_core.c was forgotten when some changes were made 
that are in bk-pci...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

