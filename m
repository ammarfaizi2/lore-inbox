Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWASQJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWASQJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWASQJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:09:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26385 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161296AbWASQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:09:46 -0500
Date: Thu, 19 Jan 2006 17:09:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jes Sorensen <jes@sgi.com>
Cc: Dave Jones <davej@redhat.com>, pfg@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 patch] drivers/sn/ must be entered for CONFIG_SGI_IOC3
Message-ID: <20060119160944.GN19398@stusta.de>
References: <20060117235521.GA14298@redhat.com> <20060119032423.GI19398@stusta.de> <yq0vewg7dc7.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0vewg7dc7.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:54:00AM -0500, Jes Sorensen wrote:
> >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
> 
> Adrian> On Tue, Jan 17, 2006 at 06:55:21PM -0500, Dave Jones wrote:
> >> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol
> >> ioc3_unregister_submodule
> >> 
> >> CONFIG_SERIAL_SGI_IOC3=m CONFIG_SGI_IOC3=m
> 
> Adrian> The untested patch below should fix it.
> 
> Actually I think this is more appropriate so we don't end up with 17
> cases that add drivers/sn to the build lib.
>...

I haven't tested your patch, but I agree that it's a better approach 
than my patch.
 
> Cheers,
> Jes
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

