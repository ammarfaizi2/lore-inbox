Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWGTGHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWGTGHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 02:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGTGHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 02:07:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51974 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030277AbWGTGHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 02:07:37 -0400
Date: Thu, 20 Jul 2006 08:07:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
Message-ID: <20060720060736.GA25367@stusta.de>
References: <20060718091807.467468000@sous-sol.org> <20060718091950.750213000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718091950.750213000@sous-sol.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 12:00:09AM -0700, Chris Wright wrote:
>...
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/arch/i386/mach-xen/setup-xen.c	Thu Jun 22 20:20:31 2006 -0400
>...
> +struct start_info *xen_start_info;
> +EXPORT_SYMBOL(xen_start_info);

EXPORT_SYMBOL_GPL?

> +/*
> + * Point at the empty zero page to start with. We map the real shared_info
> + * page as soon as fixmap is up and running.
> + */
> +struct shared_info *HYPERVISOR_shared_info = (struct shared_info *)empty_zero_page;
> +EXPORT_SYMBOL(HYPERVISOR_shared_info);
>...

EXPORT_SYMBOL_GPL?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

