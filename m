Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVHSR2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVHSR2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbVHSR2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:28:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62991 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932556AbVHSR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:28:45 -0400
Date: Fri, 19 Aug 2005 19:28:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-mm1: too many 'ipv4_table' variables
Message-ID: <20050819172842.GG3682@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
>  git-net.patch
>...
>  Subsystem trees
>...

It seems there are too many different 'ipv4_table' variables:

<--  snip  -->

...
  CC      net/ipv4/ipvs/ip_vs_ctl.o
net/ipv4/ipvs/ip_vs_ctl.c:1601: error: static declaration of 'ipv4_table' follows non-static declaration
include/net/ip.h:376: error: previous declaration of 'ipv4_table' was here
make[3]: *** [net/ipv4/ipvs/ip_vs_ctl.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

