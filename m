Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVA2IOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVA2IOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVA2IOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:14:37 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21500 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262879AbVA2IO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:14:27 -0500
Date: Fri, 28 Jan 2005 23:30:06 -0500
From: Christopher Li <lkml@chrisli.org>
To: Roland Dreier <roland@topspin.com>
Cc: Christopher Li <chrisl@vmware.com>,
       Gianni Tedesco <gianni@scaramanga.co.uk>,
       linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: Re: compat ioctl for submiting URB
Message-ID: <20050129043006.GA12806@64m.dyndns.org>
References: <20050128212304.GA11024@64m.dyndns.org> <1106972991.3972.57.camel@sherbert> <20050129013305.GA7792@64m.dyndns.org> <52brb8vldp.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52brb8vldp.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is nice to know all that. I guess I did not know much about
the other 64 bit systems. I will update and resend my patch.

Thanks!

Chris

On Fri, Jan 28, 2005 at 09:45:38PM -0800, Roland Dreier wrote:
>     Christopher> This patch is for the case that running 32 bit
>     Christopher> application on a 64 bit kernel. So far only x86_64
>     Christopher> allow you to do that.
> 
> Actually, at least ia64, mips, parisc, ppc64, s390 and sparc64 also
> support 32-bit applications on a 64-bit kernel.  All of those
> architectures except s390 can use USB.  I guess vmware doesn't run on
> most of those architectures but any solution in the mainline kernel
> should be generic enough to handle them all.
> 
>  - R.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
