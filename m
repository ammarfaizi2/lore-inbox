Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWAQXFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWAQXFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAQXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:05:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57001
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964877AbWAQXFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:05:45 -0500
Date: Tue, 17 Jan 2006 15:05:28 -0800 (PST)
Message-Id: <20060117.150528.108145661.davem@davemloft.net>
To: galak@kernel.crashing.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: NIP6_FMT "breaks" ifconfig
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <26F1D638-7A96-48C6-9191-74363C497820@kernel.crashing.org>
References: <26F1D638-7A96-48C6-9191-74363C497820@kernel.crashing.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 17 Jan 2006 16:35:01 -0600

> The use of NIP6_FMT from kernel.h in net/ipv6/addrconf.c changes how / 
> proc/net/if_inet6 format's IPv6 addresses and thus breaks ifconfig's  
> ability to display IPv6 addresses.  I'm not sure if this is  
> acceptable breakage of a userspace app or not.

I know, I have a fix from Yoshifuji in my tree and I'll
make sure Linus gets it.
