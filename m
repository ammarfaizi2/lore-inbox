Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRHPTvg>; Thu, 16 Aug 2001 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271648AbRHPTv0>; Thu, 16 Aug 2001 15:51:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14345 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S271657AbRHPTvI>; Thu, 16 Aug 2001 15:51:08 -0400
Date: Thu, 16 Aug 2001 21:51:13 +0200
From: Jan Kara <jack@suse.cz>
To: Zakhar Kirpichenko <zakhar@silver.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disk quota + 2.4.3 and higher -- OOPS
Message-ID: <20010816215113.G9790@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.10.10108151641270.10516-100000@rasta.silver.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10108151641270.10516-100000@rasta.silver.com.ua>; from zakhar@silver.com.ua on Wed, Aug 15, 2001 at 04:50:25PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> 	Sorry for offtopic (may be), but disk quotas don't work on Red Hat
> Linux 7.1 and kernels 2.2.x and 2.4.x. Quota tools installed from RPM
> package provided in standard RH distribution: quota-3.00-4, 2.4.2-2 kernel
> sources taken from the dist too. Other kernel versions support quota
> partially: repquota gives some quota statistics, but the kernel doesn't
> update quota data until 'quotacheck' is run manually. Disk quotas don't
> work too - even when repquota shows some limits, 'quota' doesn't and any
> user can write to the fs inspite of the disk limits.
  And what does say command 'quotaon -avug' executed as root? It seems to me
like quotas aren't turned on in kernel...

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
