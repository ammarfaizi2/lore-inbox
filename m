Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVKXKf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVKXKf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbVKXKf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:35:26 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:20697 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750994AbVKXKfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:35:25 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
References: <20051118033302.GO11494@stusta.de>
	<20051118090158.GA11621@flint.arm.linux.org.uk>
	<437DFD6C.1020106@pobox.com>
	<20051123221547.GM15449@flint.arm.linux.org.uk>
	<20051123222410.GN15449@flint.arm.linux.org.uk>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 24 Nov 2005 10:30:40 +0000
In-Reply-To: <20051123222410.GN15449@flint.arm.linux.org.uk> (Russell King's
 message of "Wed, 23 Nov 2005 22:24:10 +0000")
Message-ID: <tnxd5kqcp7z.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Nov 2005 10:30:42.0338 (UTC) FILETIME=[1F014820:01C5F0E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2005 at 10:15:48PM +0000, Russell King wrote:
>> Well, I've run 2.6.15-rc2 on what I think was the ARM platform which
>> exhibited the problem, but it doesn't show up.
>
> The test was merely a "did it successfully BOOTP" because I can't
> get it to mount and run /sbin/init from the jffs2 rootfs which
> 2.5.70 was perfectly happy to earlier today.  However, the
> failure point seemed to be when NFS tried to use the card.

If you you are referring to the ARM Integrator/AP platform, I tested
it earlier this year, with a 2.6.12 kernel, and the e100.c driver
seemed to be OK with an NFS-mounted root filesystem and the IP address
got via kernel DHCP. I had problems getting the eepro100.c driver to
work though, but I didn't dig any further since e100.c seemed OK.

I'll give it another try early next week with 2.6.15-rc2 and let you
know whether I see any problems.

-- 
Catalin

