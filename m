Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVANWld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVANWld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVANWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:41:32 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:4240 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261338AbVANWla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:41:30 -0500
Message-ID: <41E84A92.5030807@am.sony.com>
Date: Fri, 14 Jan 2005 14:41:22 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>   haven't yet taken as close a look at LTT as I should have.  Probably neither
>   have you.
> 
>   It needs a bit of work on the kernel<->user periphery, which is not a big
>   deal.
> 
>   As does relayfs, IMO.  It seems to need some regularised way in which a
>   userspace relayfs client can tell relayfs what file(s) to use.  LTT is
>   currently using some ghastly stick-a-pathname-in-/proc thing.  Relayfs
>   should provide this service.
> 
>   relayfs needs a closer look too.  A lot of advanced instrumentation
>   projects seem to require it, but none of them have been merged.  Lots of
>   people say "use netlink instead" and lots of other people say "err, we think
>   relayfs is better".  This is a discussion which needs to be had.

Thanks very much.  I know lots of embedded folks who will be happy to
see this discussion take place.  (As an aside, I'll try to encourage
some of our more shy members to speak up and participate in the
discussion as well.  I know Hitachi has been doing some work on
tracing, and I'd hate to see duplicate effort.)

BTW - I agree with most of the relayfs comments.  It seems like overkill
for the kernel developer doing a "casual", ad-hoc trace.  I'll try to
work with Karim on the suggested improvements.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
