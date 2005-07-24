Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVGXRIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVGXRIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVGXRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 13:08:06 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:41624 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261244AbVGXRHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 13:07:49 -0400
Date: Sun, 24 Jul 2005 10:07:33 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: pavel@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-Id: <20050724100733.3b363599.rdunlap@xenotime.net>
In-Reply-To: <20050724174756.A20019@flint.arm.linux.org.uk>
References: <20050722180109.GA1879@elf.ucw.cz>
	<20050724174756.A20019@flint.arm.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 17:47:56 +0100 Russell King wrote:

> On Fri, Jul 22, 2005 at 08:01:09PM +0200, Pavel Machek wrote:
> > This adds support for reading ADCs (etc), neccessary to operate touch
> > screen on Sharp Zaurus sl-5500.
> 
> I would like to know what the diffs are between my version (attached)
> and this version before they get applied.
> 
> The only reason my version has not been submitted is because it lives
> in the drivers/misc directory, and mainline kernel folk don't like
> drivers which clutter up that directory.  In fact, I had been told
> that drivers/misc should remain completely empty - which makes this
> set of miscellaneous drivers homeless.

but clearly drivers/misc/ is not empty, unless you mean at its
top level.

The IBM ASM service processor driver is there (added in 2.6.x)
as well as some hdpuftrs/ driver, which is not in any Kconfig file
or defconfig file.  :(

---
~Randy
