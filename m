Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWFALAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWFALAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWFALAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:00:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64719 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965072AbWFALAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:00:02 -0400
Date: Thu, 1 Jun 2006 12:53:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Stephane Eranian <eranian@hpl.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/11] 2.6.17-rc5 perfmon2 patch for review: modified i386
 files
In-Reply-To: <20060601103111.GA29421@frankl.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0606011251370.17704@scrub.home>
References: <200605311352.k4VDqV88028437@frankl.hpl.hp.com>
 <Pine.LNX.4.64.0605311620150.17704@scrub.home> <20060601103111.GA29421@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Stephane Eranian wrote:

> > > +config PERFMON
> > > +  	bool "Perfmon2 performance monitoring interface"
> > > +	select X86_LOCAL_APIC
> > > +	default y
> > 
> > Drop the defaults and I'm pretty sure you don't want to use select.
> > 
> What's wrong with 'default y' ?

Why should it be enabled by default?

> Are you suggesting I use 'depends' instead of select?

That's one possibility. Why did you select in the first place?

bye, Roman
