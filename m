Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752944AbWKCCLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbWKCCLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbWKCCLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:11:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56842 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752937AbWKCCLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:11:44 -0500
Date: Fri, 3 Nov 2006 03:11:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
Message-ID: <20061103021145.GD13381@stusta.de>
References: <1162485897.10806.72.camel@localhost.localdomain> <m1d5851yxd.fsf@ebiederm.dsl.xmission.com> <1162492453.10806.75.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162492453.10806.75.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 10:34:13AM -0800, Tim Chen wrote:
> On Thu, 2006-11-02 at 11:33 -0700, Eric W. Biederman wrote:
> 
> > My only partial guess is that it might be worth adding the per cpu
> > variables my patch adds without any of the corresponding code changes.
> > And see if adding variables to the per cpu area is what is causing the
> > change.
> > 
> > The two tests I can see in this line are:
> > - to add the percpu vector_irq variable.
> > - to increase NR_IRQs.
> 
> Increasing the NR_IRQs resulted in the regression.
>...

What's your CONFIG_NR_CPUS setting that you are seeing such a big
regression?

> Tim

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

