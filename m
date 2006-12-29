Return-Path: <linux-kernel-owner+w=401wt.eu-S1750925AbWL2KYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWL2KYB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWL2KYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:24:01 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:5645 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750804AbWL2KYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:24:00 -0500
Date: Fri, 29 Dec 2006 11:23:58 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
cc: Al Viro <viro@ftp.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: [updated PATCH] remove 555 unneeded #includes of sched.h
In-Reply-To: <Pine.LNX.4.63.0612282239190.20531@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.63.0612291115160.5654@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
 <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
 <20061228213438.GD20596@flint.arm.linux.org.uk>
 <Pine.LNX.4.63.0612282239190.20531@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Tim Schmielau wrote:
> On Thu, 28 Dec 2006, Russell King wrote:
> 
> > To cover these, you need to build at least rpc_defconfig, lubbock_defconfig,
> > netwinder_defconfig, badge4_defconfig, cerf_defconfig, ...etc...
> 
> OK, I'll try to do that.
> Do I need to build all the configs in arch/arm/configs?

OK, building 2.6.20-rc2-mm1 with all 59 configs from arch/arm/configs 
with and w/o the patch indeed found one mysterious #include that may not 
be removed. Thanks, Russell!

Andrew, please use the attached patch instead of the previous one, it also 
has a slightly better patch description.

Thanks,
Tim
