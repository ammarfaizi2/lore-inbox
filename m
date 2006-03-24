Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWCXHzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWCXHzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWCXHzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:55:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12819 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422778AbWCXHzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:55:13 -0500
Date: Fri, 24 Mar 2006 08:55:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jing Min Zhao <zhaojingmin@hotmail.com>
Cc: Jing Min Zhao <zhaojignmin@hotmail.com>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 patch] ip_conntrack_helper_h323.c: make get_h245_addr()static
Message-ID: <20060324075511.GV22727@stusta.de>
References: <20060324000916.GN22727@stusta.de> <BAY109-DAV122F44146DB217251703AEB3DF0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY109-DAV122F44146DB217251703AEB3DF0@phx.gbl>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:37:15PM -0500, Jing Min Zhao wrote:
> 
> I'd like to keep it global. In the future we may need it.

The point is:
There have been many occasions where people have said "I will need this 
soon" in many different places in the kernel, and one year later it was 
still unused.

If it will be needed at some point in the future, reverting my patch
will be trivial.

> Thanks
> 
> Jing Min Zhao

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

