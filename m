Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWDOVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWDOVcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWDOVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:32:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751189AbWDOVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:32:16 -0400
Date: Sat, 15 Apr 2006 23:32:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: David Miller <davem@davemloft.net>, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [NFS] [RFC: 2.6 patch] net/sunrpc/: possible cleanups
Message-ID: <20060415213215.GN15022@stusta.de>
References: <044B81DE141D7443BCE91E8F44B3C1E288E4FC@exsvl02.hq.netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044B81DE141D7443BCE91E8F44B3C1E288E4FC@exsvl02.hq.netapp.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 07:13:14AM -0700, Lever, Charles wrote:

> actually, can we hold off on this change?  the RPC transport switch will
> eventually need most of those EXPORT_SYMBOLs.
>...
> > This patch was already sent on:
> > - 30 May 2005
> > - 7 May 2005
>...

One year has passed since I sent this patch the first time, and with the 
exception that it needs re-diff'ing it still applies.

Charles, are the changes you are talking about that might need them 
available in the very near future?

If not, I'd suggest to remove them and re-add them when code using them 
will be included in the kernel (reverting parts or all of my patch 
should be trivial).

This way, they'll not continue to uselessly making the kernel image 
larger.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

