Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVCCD2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVCCD2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVCCDYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:24:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:28590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261367AbVCCDWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:22:43 -0500
Message-ID: <42268037.3040300@osdl.org>
Date: Wed, 02 Mar 2005 19:10:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com>
In-Reply-To: <20050303002733.GH10124@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:
> 
>  > I would not keep regular driver updates from a 2.6.<even> thing. 
> 
> Then the notion of it being stable is bogus, given how many regressions
> the last few kernels have brought in drivers.  Moving from 2.6.9 -> 2.6.10
> broke ALSA, USB, parport, firewire, and countless other little bits and
> pieces that users tend to notice.
> 
> The reason that things like 4-level page tables worked out so well
> was that it was tested in -mm for however long, so by the time it got
> to your tree, the silly bugs had already been shaken out.
> 
> Compare this to random-driver-update.  -mm testing is a valuable
> proving ground, but its no panacea to stability. There's no guarantee
> that someone with $affected_device even tried a -mm kernel.
> 
> For it to truly be a stable kernel, the only patches I'd expect to
> drivers would be ones fixing blindingly obvious bugs. No cleanups.
> No new functionality. I'd even question new hardware support if it
> wasn't just a PCI ID addition.

Maybe I don't understand?  Is someone expecting distro
quality/stability from kernel.org kernels?
I don't, but maybe I'm one of those minorities.

-- 
~Randy
