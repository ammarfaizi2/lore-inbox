Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTICQPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTICQPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:15:45 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:61582 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263963AbTICQOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:14:37 -0400
Date: Wed, 3 Sep 2003 18:14:35 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quota Hash Abstraction 2.6.0-test2
Message-ID: <20030903161435.GC24897@DUK2.13thfloor.at>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <20030731184341.GA21078@www.13thfloor.at> <bj4vfq$6to$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bj4vfq$6to$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 02:56:58PM +0000, bill davidsen wrote:
> In article <20030731184341.GA21078@www.13thfloor.at>,
> Herbert =?iso-8859-1?Q?P=F6tzl?=  <herbert@13thfloor.at> wrote:
> 
> Is any of this, particularly the work mentioned in the last paragraph
> getting into the mail kernel?

the quota fix was included in the next (test) release
so default quota will work again ...

the Quota Hash Abstraction is neither a (big) performance
gain nor a feature bonus for the end user ... it is more
an enhancement to the code itself, allowing to have more
than one quota hash for arbitrary purposes ...

I doubt, that this code will ever make it into mainline
without another 'good' reason to use it, but maybe the
--bind mount quota stuff would be such a reason, if the 
interest for such things will eventually grow ...

HTH,
Herbert

> | Last time I posted the Quota Hash Abstraction for 2.4
> | somebody suggested doing it for 2.6, because it "might
> | be interesting", so I thought, give it a try, and here
> | it is ...
> | 
> | please, if somebody has any quota tests, which he/she
> | is willing to do on this code, or just want to do some
> | testing with this code, do it and send me the results ...
> | 
> | this patch requires the quota fix done by Jan Kara, 
> | otherwise quota would not work at all ... 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
