Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291749AbSBNQJx>; Thu, 14 Feb 2002 11:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291742AbSBNQJn>; Thu, 14 Feb 2002 11:09:43 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:49163 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S291743AbSBNQJX>; Thu, 14 Feb 2002 11:09:23 -0500
Date: Thu, 14 Feb 2002 11:09:21 -0500 (EST)
From: Vince Weaver <vince@deater.net>
X-X-Sender: <vince@hal.deaternet.vmw>
To: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: /proc key naming consistency
In-Reply-To: <Pine.LNX.4.33.0202141020140.5260-100000@dbsydn2001.aus.deuba.com>
Message-ID: <Pine.LNX.4.31.0202141104570.14558-100000@hal.deaternet.vmw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Luke Burton wrote:
> Shell parseable /proc/* entries would be so much more elegant to deal with
> compared to the old system. I would guess that maintainers for things like
> KDE would jump at the opportunity to decrease the complexity of their
> code.

as a maintainer of "linux_logo" which delves heavily (and perhaps
unwisely) into /proc/cpuinfo and its ilk, I would definitely say I would
not be jumping at the opportunity.

Remember as maintainers of userspace apps, we have to keep compatibility,
in this case for me it involves /proc/cpuinfo from all the architectures,
plus kernels going back to the 1.2.13 time-frame.

So changing /proc/cpuinfo yet again does not simplify the code, in fact it
just adds one more incompatible special case.

And since 2.2 and 2.4 kernels will be around for ages to come, it will
make code bigger rather than smaller.

I agree a cleanup, if done properly, would be welcomed.  but don't use
"simplification of user-space code" as an argument.. because it's a lie ;)

Vince

who is perhaps bitter because of all the gratuitious "spaces.. no, tabs..
no, underscores" and "bogomips BOGOmips BogoMips BoGoMiPs bobo_mips" type
changes over the years

-- 
____________
\  /\  /\  /  Vince Weaver        Linux 2.4.17-rc1 on a K6-2+, Up 59 days
 \/__\/__\/   vince@deater.net    http://www.deater.net/weave

