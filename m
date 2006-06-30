Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWF3B33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWF3B33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWF3B33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:29:29 -0400
Received: from mga07.intel.com ([143.182.124.22]:54597 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751394AbWF3B32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:29:28 -0400
X-IronPort-AV: i="4.06,193,1149490800"; 
   d="scan'208"; a="59507056:sNHT34479928"
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060629162214.GB18767@colo.lackof.org>
References: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
	 <20060629162214.GB18767@colo.lackof.org>
Content-Type: text/plain
Message-Id: <1151630897.28493.107.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 30 Jun 2006 09:28:17 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 00:22, Grant Grundler wrote:
> Yanmin,
> Just one nit...
Thanks for your kind comments!

> 
> On Thu, Jun 29, 2006 at 09:12:27AM +0800, Zhang, Yanmin wrote:
> > Patch 1 consists of the pciaer-howto.txt document.
> ...
> > +In existing Linux kernels, 2.4.x and 2.6.x, there is no root service
> > +driver available to manage the PCI Express advanced error reporting
> > +extended capability structure.
> 
> "existing Linux kernels" won't mean anything 3 years.
> You might be more specific such as "All kernels before 2.6.18 released..."
I will change it.

> 
> 
> ...
> > +To provide a solution to these BIOS issues requires the PCI Express AER
> > +Root driver that provides:
> > +
> > +- 	A mechanism for the OS and application to determine if a fatal
> > +	error is fatal to the system, OS, or application increasing
> > +	uptime.
> 
> The word "mechanism" is used frequently.
> I wonder if sometimes (like above) "infrastructure" is meant.
I will change to 'infrastructure'.

> 
> > +8. Frequent Asked Questions
> 
> I'd be tempted to make the FAQ the next section after the introduction.
As a matter of fact, FAQ is complementarity to prior sections. If it is moved
just after the introduction, readers might be confused and I assume readers might
be unable to ask such questions before reading prior sections. :)
