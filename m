Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423066AbWANFFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423066AbWANFFw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWANFFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:05:52 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:58843 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030394AbWANFFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:05:50 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Fri, 13 Jan 2006 22:05:30 -0700
User-Agent: KMail/1.8.3
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com> <200601140219.39765.ak@suse.de>
In-Reply-To: <200601140219.39765.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601132205.30675.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 18:19, Andi Kleen wrote:
> On Saturday 14 January 2006 01:24, Bjorn Helgaas wrote:
> > On Friday 06 January 2006 15:39, Matt Domsch wrote:
> > > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > > ...
> > > +config DMI
> > > +       bool
> > > +       default y
> >
> > Should we have a way to turn this off?
> 
> At least on i386/x86-64 it is largely used for hardware/firmware bug 
> workaround and these have been traditionally always compiled in
> 
> Or do you want to spend a lot of time on a bug report from
> a user only to discover they didn't enable the workarounds for
> their particular platform?

Yeah, that was a dumb idea.  I just need to fix whatever's
currently broken and then there'll be no harm in having it
all the time.
