Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUIOOU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUIOOU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUIOOQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:16:52 -0400
Received: from cpc2-sout5-5-0-cust135.sot3.cable.ntl.com ([81.110.110.135]:6160
	"EHLO teh.ath.cx") by vger.kernel.org with ESMTP id S266236AbUIOOMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:12:42 -0400
Date: Wed, 15 Sep 2004 15:12:37 +0100
From: Matt Kavanagh <matthew@teh.ath.cx>
To: Patrick Kiwitter- Mailinglist <ccc@devilcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: monoholitic, hybrid or not monoholitic?
Message-ID: <20040915141237.GB2429@teh.ath.cx>
References: <4148271D.9050009@devilcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148271D.9050009@devilcode.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:27:25PM +0200, Patrick Kiwitter- Mailinglist wrote:
> Hash: SHA1
> 
> hello world,
> 
> i've invested a couple of hours to find a correct description of the
> linux kernel achritecture. most books or litretures (in general) are
> talking about a monoholitic kernel (incl. linux kernel development -
> robert love and understanding the linux kernel - oreilly). i also asked
> google an read the kernel.org faq.
> 
> the kernel were mostly descripted as monoholitic. but some sources means
> that the linux kernel is not really monoholitic because of the feature
> of loading kernel modules. some pages are talking about a "hybrid
> kernel" which means that the kernel is a glue one, a little bit of
> monoholitic and a little bit not.
> 
> so i would like to receive detailed information where i can read a
> correct description of course you can also post your comments here (if
> allowed). by the way, yes i've read the "tanenbaum" reffering monoholitc.
> 
> thanks a lot in advanced,
> patrick
> 
I'd tend towards monolithic because the modules (as mentioned) run in kernel
space; but it's not a cookie-cutter case. Things are implemented in userspace
that provide functionality normally included in the kernel; udev springs to
mind, even if it is not the predominant solution.
