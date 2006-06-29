Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWF2QWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWF2QWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWF2QWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:22:18 -0400
Received: from colo.lackof.org ([198.49.126.79]:30349 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750836AbWF2QWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:22:17 -0400
Date: Thu, 29 Jun 2006 10:22:14 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
Message-ID: <20060629162214.GB18767@colo.lackof.org>
References: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yanmin,
Just one nit...

On Thu, Jun 29, 2006 at 09:12:27AM +0800, Zhang, Yanmin wrote:
> Patch 1 consists of the pciaer-howto.txt document.
...
> +In existing Linux kernels, 2.4.x and 2.6.x, there is no root service
> +driver available to manage the PCI Express advanced error reporting
> +extended capability structure.

"existing Linux kernels" won't mean anything 3 years.
You might be more specific such as "All kernels before 2.6.18 released..."


...
> +To provide a solution to these BIOS issues requires the PCI Express AER
> +Root driver that provides:
> +
> +- 	A mechanism for the OS and application to determine if a fatal
> +	error is fatal to the system, OS, or application increasing
> +	uptime.

The word "mechanism" is used frequently.
I wonder if sometimes (like above) "infrastructure" is meant.

> +8. Frequent Asked Questions

I'd be tempted to make the FAQ the next section after the introduction.

hth,
grant
