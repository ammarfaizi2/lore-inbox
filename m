Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVDDCvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVDDCvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDDCvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:51:46 -0400
Received: from fmr19.intel.com ([134.134.136.18]:32421 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261982AbVDDCvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:51:38 -0400
Subject: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050403194807.32fd761a.akpm@osdl.org>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:49:07 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 10:48, Andrew Morton wrote:
> Li Shaohua <shaohua.li@intel.com> wrote:
> >
> > On Mon, 2005-04-04 at 10:37, Andrew Morton wrote:
> > > Li Shaohua <shaohua.li@intel.com> wrote:
> > > >
> > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > >  tree.
> > > 
> > > Should I merge that thing into mainline?  It seems that a few people are
> > > needing it.
> > I'd like to listen to some comments first. There are still some things
> > I'm not sure, such as the do_exit_idle.
> > 
> 
> I was referring to Zwane's i386-cpu-hotplug-updated-for-mm.patch
Yep, great. Pavel's swsusp also need it.

Thanks,
Shaohua

