Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVCISSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVCISSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVCISSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:18:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29388 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261725AbVCISRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:17:54 -0500
Date: Wed, 9 Mar 2005 11:03:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309140359.GB15110@logos.cnet>
References: <20050309083923.GA20461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309083923.GA20461@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

The st/ide-tape/osst llseek changes havent been applied for what reason? 

And what about the rest of fixups which Andrew sent you? 

I suppose they didnt pass the -stable criteria. Can you share your thoughts 
with the rest of us?

On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
> And to further test this whole -stable system, I've released 2.6.11.2.
> It contains one patch, which is already in the -bk tree, and came from
> the security team (hence the lack of the longer review cycle).
> 
> It's available now in the normal kernel.org places:
> 	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
> which is a patch against the 2.6.11.1 release.  If consensus arrives
> that this patch should be against the 2.6.11 tree, it will be done that
> way in the future.
> 
> A detailed changelog can be found at:
>  	kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.11.2
> 
> A bitkeeper tree for the 2.6.11.y releases can be found at:
> 	bk://linux-release.bkbits.net/linux-2.6.11
> 
> The diffstat and short summary of the fixes are below.  
> 
> I'll also be replying to this message with a copy of the patch itself,
> as it is small enough to do so.
> 
> thanks,
>  
> greg k-h
> 
> -------
> 
> 
>  Makefile       |    2 +-
>  fs/eventpoll.c |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
> Summary of changes from v2.6.11.1 to v2.6.11.2
> ============================================
> 
> Greg Kroah-Hartman:
>   o Linux 2.6.11.2
> 
> Linus Torvalds:
>   o epoll: return proper error on overflow condition
