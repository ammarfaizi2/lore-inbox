Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268827AbTCCVaT>; Mon, 3 Mar 2003 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268828AbTCCVaT>; Mon, 3 Mar 2003 16:30:19 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:1479 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id <S268827AbTCCVaS>;
	Mon, 3 Mar 2003 16:30:18 -0500
Date: Mon, 3 Mar 2003 14:40:39 -0700
From: Matt Porter <porter@cox.net>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, porter@cox.net, linux-kernel@vger.kernel.org
Subject: Re: *dma_sync_single API change to support non-coherent cpus
Message-ID: <20030303144039.C31278@home.com>
References: <20030303111848.A31278@home.com> <20030303195825.C17997@flint.arm.linux.org.uk> <20030303.114723.65560821.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030303.114723.65560821.davem@redhat.com>; from davem@redhat.com on Mon, Mar 03, 2003 at 11:47:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:47:23AM -0800, David S. Miller wrote:
>    From: Russell King <rmk@arm.linux.org.uk>
>    Date: Mon, 3 Mar 2003 19:58:25 +0000
>    
>    DaveM, as the author of the original PCI DMA API, any comments on this
>    (probably ill-thoughtout) idea?
> 
> Maybe a better idea is to kill map_single() altogether, and use
> scatterlists everywhere.
> 
> Long term this is the kind of consolidation that ought to
> happen anyways.
> 
> And then the implementation can stick whatever it wants in there.

Eliminating map_single() does solve our problem, but I take "Long term"
to mean 2.7.  Is the proposed solution acceptable for 2.5/2.6 or are
we stuck documenting the limitation until 2.7?

Thanks,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
