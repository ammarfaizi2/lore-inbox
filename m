Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWEHGDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEHGDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEHGDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:03:13 -0400
Received: from S010600138f6abc78.vc.shawcable.net ([24.85.144.67]:47025 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S932331AbWEHGDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:03:13 -0400
Date: Sun, 7 May 2006 23:02:15 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Shaohua Li <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/10] i386 implementation of cpu bulk removal
In-Reply-To: <1147067152.2760.85.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.64.0605072301201.2496@montezuma.fsmlabs.com>
References: <1147067152.2760.85.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Shaohua Li wrote:

> +config BULK_CPU_REMOVE
> +	bool "Support for bulk removal of CPUs (EXPERIMENTAL)"
> +	depends on HOTPLUG_CPU && EXPERIMENTAL
> +	help
> +	  Say Y if need the ability to remove more than one cpu during cpu
> +	  removal. Current mechanisms may be in-efficient when a NUMA
> +	  node is being removed, which would involve removing one cpu at a
> +	  time. This will let interrupts, timers and processes to be bound
> +	  to a CPU that might be removed right after the current cpu is
> +	  being offlined.
> +

Hello Shaohua,
	Is this config option a temporary/staging thing?

Thanks,
	Zwane
