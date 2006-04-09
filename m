Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWDIEJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWDIEJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 00:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWDIEJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 00:09:57 -0400
Received: from stinky.trash.net ([213.144.137.162]:56539 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S965075AbWDIEJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 00:09:56 -0400
Message-ID: <44388908.6070602@trash.net>
Date: Sun, 09 Apr 2006 06:09:44 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vherva@vianova.fi
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060408200915.GN1686@vianova.fi>
In-Reply-To: <20060408200915.GN1686@vianova.fi>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> I upgraded from 2.6.15-rc7 to 2.6.17-rc1. rc1 seems nice other than that
> iptables stopped working:
> 
>  failed iptables v1.3.5: can't initialize iptables table filter: iptables
>  who? (do you need to insmod?) 
>  Perhaps iptables or your kernel needs to be upgraded.
> 
> iptables is compiled in the kernel, not a module:
>  CONFIG_NETFILTER=y
> 
> I can even do "modprobe iptable_nat" successfully (iptable_nat is module),
> but iptables refuses to work. iptables is of version iptables-1.3.5-1.2. 
> 
> The kernel config is copied with make oldconfig from 2.6.15-rc7 (which
> worked), not much else has changed. I just booted back to 2.6.15-rc7 and
> verified it works. Any ideas?

Most likely you didn't enable the new xtables options. Please post your
full config.

