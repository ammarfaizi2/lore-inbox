Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWFAKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWFAKiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWFAKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:38:14 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:32132 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750817AbWFAKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:38:13 -0400
Date: Thu, 1 Jun 2006 03:31:11 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/11] 2.6.17-rc5 perfmon2 patch for review: modified i386 files
Message-ID: <20060601103111.GA29421@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200605311352.k4VDqV88028437@frankl.hpl.hp.com> <Pine.LNX.4.64.0605311620150.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605311620150.17704@scrub.home>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 04:21:49PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 31 May 2006, Stephane Eranian wrote:
> 
> > diff -ur linux-2.6.17-rc5.orig/arch/i386/Kconfig linux-2.6.17-rc5/arch/i386/Kconfig
> > --- linux-2.6.17-rc5.orig/arch/i386/Kconfig	2006-05-30 05:31:59.000000000 -0700
> > +++ linux-2.6.17-rc5/arch/i386/Kconfig	2006-05-30 02:48:12.000000000 -0700
> > @@ -763,6 +763,21 @@
> >  	  /sys/devices/system/cpu.
> >  
> >  
> > +menu "Hardware Performance Monitoring support"
> > +
> > +config PERFMON
> > +  	bool "Perfmon2 performance monitoring interface"
> > +	select X86_LOCAL_APIC
> > +	default y
> 
> Drop the defaults and I'm pretty sure you don't want to use select.
> 
What's wrong with 'default y' ?
Are you suggesting I use 'depends' instead of select?

Thanks.

-- 
-Stephane
