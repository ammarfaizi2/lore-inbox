Return-Path: <linux-kernel-owner+w=401wt.eu-S1753030AbWLWJhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbWLWJhx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbWLWJhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1182 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753030AbWLWJhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:31 -0500
Date: Sat, 23 Dec 2006 09:33:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/10] local_t : adding and standardising atomic primitives
Message-ID: <20061223093358.GF3960@ucw.cz>
References: <20061221001545.GP28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221001545.GP28643@Krystal>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> These patches extend and standardise local_t operations on each architectures,
> allowing a rich set of atomic operations to be done on per-cpu data with
> minimal performance impact. On some architectures, there seems to be no
> difference between the SMP and UP operation (same memory barriers, same
> LOCking), local.h simply includes asm-generic/local.h, which removes duplicated
> code.

Could you provide some Documentation/? Knowing when local_t can be
used is kind-of important.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
