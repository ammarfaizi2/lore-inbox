Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWCXA3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWCXA3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWCXA3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:29:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9745 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751179AbWCXA3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:29:08 -0500
Date: Fri, 24 Mar 2006 01:29:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: zhaojignmin@hotmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [2.6 patch] ip_conntrack_helper_h323.c: EXPORT_SYMBOL'ed functions shouldn't be static
Message-ID: <20060324002907.GQ22727@stusta.de>
References: <20060324000801.GM22727@stusta.de> <20060323.161314.59991770.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323.161314.59991770.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 04:13:14PM -0800, David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Fri, 24 Mar 2006 01:08:01 +0100
> 
> > EXPORT_SYMBOL'ed functions shouldn't be static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Fixed in Linus's tree as of yesterday.

Sorry for missing this, this must have been after Andrew pulled Linus' 
tree for creating 2.6.16-mm1 (which is where I was looking at).

> I actually have a patch from Patrick McHardy that will make
> this kind of error a build time failure instead of silently
> working in the modular case.  I just need to test it out
> a bit before pushing.

Yes, it would be nice if it would also fail in CONFIG_MODULES=y builds.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

