Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWEIXWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWEIXWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWEIXWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:22:35 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31106 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932092AbWEIXWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:22:35 -0400
Date: Tue, 9 May 2006 16:23:35 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060509232335.GE24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <20060509100547.GL3570@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509100547.GL3570@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> On Tue, May 09, 2006 at 12:00:01AM -0700, Chris Wright wrote:
> >...
> > --- linus-2.6.orig/arch/i386/Kconfig
> > +++ linus-2.6/arch/i386/Kconfig
> >...
> >  config X86_IO_APIC
> >  	bool
> > -	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
> > +	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN))
> >  	default y
> >...
> 
> <nitpick>not required</nitpick>

True, although SMP is just disabled in this patchset which is a subset
of full Xen support.

thanks,
-chris
