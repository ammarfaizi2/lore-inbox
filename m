Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUHCArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUHCArq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUHCArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:47:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8438 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264750AbUHCApM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:45:12 -0400
Date: Tue, 3 Aug 2004 02:45:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-ID: <20040803004509.GW2746@fs.tum.de>
References: <20040802225951.GR2746@fs.tum.de> <20040802162846.3929e463.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802162846.3929e463.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 04:28:46PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > I'd like to see the patch below included in 2.6.8 .
> 
> I'm not seeing many (any) bug reports from this, and I'd generally prefer
> to keep people pushing down on the stack utilisation anyway.
> 
> So I'm disinclined to reduce 4k stacks' testing coverage...

There are still more than enough people with EXPERIMENTAL=y to give a 
decent testing coverage.

OTOH, at least XFS is known to have problems with 4kb stacks - and you 
don't want such problems to occur in production environments.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

