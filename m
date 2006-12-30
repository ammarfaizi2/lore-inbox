Return-Path: <linux-kernel-owner+w=401wt.eu-S1755177AbWL3RTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbWL3RTR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 12:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbWL3RTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 12:19:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2748 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbWL3RTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 12:19:16 -0500
Date: Sat, 30 Dec 2006 17:19:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [updated PATCH] remove 555 unneeded #includes of sched.h
Message-ID: <20061230171906.GD12622@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de> <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de> <20061228210803.GR17561@ftp.linux.org.uk> <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de> <20061228213438.GD20596@flint.arm.linux.org.uk> <Pine.LNX.4.63.0612282239190.20531@gockel.physik3.uni-rostock.de> <Pine.LNX.4.63.0612291115160.5654@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612291115160.5654@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 11:23:58AM +0100, Tim Schmielau wrote:
> On Thu, 28 Dec 2006, Tim Schmielau wrote:
> > On Thu, 28 Dec 2006, Russell King wrote:
> > 
> > > To cover these, you need to build at least rpc_defconfig, lubbock_defconfig,
> > > netwinder_defconfig, badge4_defconfig, cerf_defconfig, ...etc...
> > 
> > OK, I'll try to do that.
> > Do I need to build all the configs in arch/arm/configs?
> 
> OK, building 2.6.20-rc2-mm1 with all 59 configs from arch/arm/configs 
> with and w/o the patch indeed found one mysterious #include that may not 
> be removed. Thanks, Russell!

Great, thanks for doing that.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
