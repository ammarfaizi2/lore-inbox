Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVDDH7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVDDH7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVDDH7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:59:50 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:54152 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261156AbVDDH7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:59:35 -0400
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
	 <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 04 Apr 2005 18:01:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm switching suspend2 to use hotplug too. Li, I'll try adding your
patches as well as Zwane's if you like (suspend2 can enter S3, S4 or S5
after writing the image). I'd love to try it on my HT desktop, and
hotplug will get more testing too :>

Nigel

On Mon, 2005-04-04 at 12:49, Li Shaohua wrote:
> On Mon, 2005-04-04 at 10:48, Andrew Morton wrote:
> > Li Shaohua <shaohua.li@intel.com> wrote:
> > >
> > > On Mon, 2005-04-04 at 10:37, Andrew Morton wrote:
> > > > Li Shaohua <shaohua.li@intel.com> wrote:
> > > > >
> > > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > > >  tree.
> > > > 
> > > > Should I merge that thing into mainline?  It seems that a few people are
> > > > needing it.
> > > I'd like to listen to some comments first. There are still some things
> > > I'm not sure, such as the do_exit_idle.
> > > 
> > 
> > I was referring to Zwane's i386-cpu-hotplug-updated-for-mm.patch
> Yep, great. Pavel's swsusp also need it.
> 
> Thanks,
> Shaohua
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

