Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWGaMiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWGaMiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWGaMiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:38:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44558 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932071AbWGaMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:38:23 -0400
Date: Mon, 31 Jul 2006 14:38:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-ID: <20060731123821.GC3658@stusta.de>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:26:55AM +0100, Denis Vlasenko wrote:

> Hi Hans,
> 
> The reiser4 thread seem to be longer than usual.
> Let me, a mere user, add some input.
> 
> It looks to me that delay with reiser4 acceptance
> is caused by two different things.
> 
> First, reiser4 adds those plugins which many FS people
> see as belonging to VFS layer rather than to particular FS.
> 
> And second, reiser team was a bit lax at fixing bugs.
> Not too bad when compared to other FSes, but still.
> 
> When singled out, none of these things are bad enough to hold off
> inclusion. However, combined impact of _both_ of them
> did upset maintainers enough.
>...

This is a wrong impression.

The bug fixing of reiser4 is definitely better than the average in the 
kernel. If you wanted to get e.g. the SATA drivers removed from the 
kernel, bug handling might be a point in favor of the removal. But 
that's not a problem with reiser4.

[1] tries to give an overview of the actual problems with the reiser4 
inclusion.

> vda

cu
Adrian

[1] http://wiki.kernelnewbies.org/WhyReiser4IsNotIn

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

