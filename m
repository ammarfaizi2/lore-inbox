Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHPV2v>; Thu, 16 Aug 2001 17:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHPV2m>; Thu, 16 Aug 2001 17:28:42 -0400
Received: from rasta.silver.com.ua ([193.41.160.2]:52743 "EHLO
	mail.silver.com.ua") by vger.kernel.org with ESMTP
	id <S268848AbRHPV2Y>; Thu, 16 Aug 2001 17:28:24 -0400
Date: Fri, 17 Aug 2001 00:28:23 +0300 (EEST)
From: Zakhar Kirpichenko <zakhar@silver.com.ua>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: disk quota + 2.4.3 and higher -- OOPS
In-Reply-To: <20010816215113.G9790@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10108170026410.25818-100000@rasta.silver.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Jan Kara wrote:

>   Hello,
> 
> > 	Sorry for offtopic (may be), but disk quotas don't work on Red Hat
> > Linux 7.1 and kernels 2.2.x and 2.4.x. Quota tools installed from RPM
> > package provided in standard RH distribution: quota-3.00-4, 2.4.2-2 kernel
> > sources taken from the dist too. Other kernel versions support quota
> > partially: repquota gives some quota statistics, but the kernel doesn't
> > update quota data until 'quotacheck' is run manually. Disk quotas don't
> > work too - even when repquota shows some limits, 'quota' doesn't and any
> > user can write to the fs inspite of the disk limits.
>   And what does say command 'quotaon -avug' executed as root? It seems to me
> like quotas aren't turned on in kernel...

	Nope. Disk quotas ARE turned on and ARE working properly for all
local user. Disk quotas DON'T wrok under freevsd 1.4.9-2.

> --
> Jan Kara <jack@suse.cz>
> SuSE Labs

--
Zakhar Kirpichenko.
ZAK-UANIC

