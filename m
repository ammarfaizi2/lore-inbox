Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWCJLC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWCJLC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCJLC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:02:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56537
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932235AbWCJLC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:02:56 -0500
Date: Fri, 10 Mar 2006 03:02:58 -0800 (PST)
Message-Id: <20060310.030258.55767431.davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] IPv6: Cleanups for net/ipv6/addrconf.c (kzalloc, early
 exit) v2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060212.021103.76157181.yoshfuji@linux-ipv6.org>
References: <20060210.014853.13643277.yoshfuji@linux-ipv6.org>
	<200602111737.20010.ioe-lkml@rameria.de>
	<20060212.021103.76157181.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Sun, 12 Feb 2006 02:11:03 +0900 (JST)

> In article <200602111737.20010.ioe-lkml@rameria.de> (at Sat, 11 Feb 2006 17:37:18 +0100), Ingo Oeser <ioe-lkml@rameria.de> says:
> 
> > From: Ingo Oeser <ioe-lkml@rameria.de>
> > 
> > Here are some possible (and trivial) cleanups.
> > - use kzalloc() where possible
> > - remove unused label
> > - invert allocation failure test like
> :
> > Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

This patch no longer applied cleanly, Ingo can you generate
a fresh version of your patch against my net-2.6.16 tree?

Thanks a lot!
