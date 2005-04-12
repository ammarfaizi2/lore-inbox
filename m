Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVDLNHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVDLNHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVDLNHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:07:09 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:7052 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262455AbVDLNCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:02:54 -0400
Date: Tue, 12 Apr 2005 07:04:56 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/6]physical CPU hot add
In-Reply-To: <1113310145.5155.12.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504120704250.19885@montezuma.fsmlabs.com>
References: <1113283863.27646.432.camel@sli10-desk.sh.intel.com> 
 <Pine.LNX.4.61.0504120609350.14171@montezuma.fsmlabs.com>
 <1113310145.5155.12.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Li Shaohua wrote:

> On Tue, 2005-04-12 at 20:17, Zwane Mwaikambo wrote:
> > On Tue, 12 Apr 2005, Li Shaohua wrote:
> > 
> > >  #ifdef CONFIG_HOTPLUG_CPU
> > > +int __attribute__ ((weak)) smp_prepare_cpu(int cpu)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > 
> > Any way for you to avoid using weak attribute?
> Just want to avoid more 'ifdef' or 'define empty routine for other
> archs' staffs. Someone prefer 'weak' attribute. Either way is ok to me,
> but if you think the former is better, I'd change it.

The define method is fine and preferred.

Thanks!
	Zwane

