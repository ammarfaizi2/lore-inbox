Return-Path: <linux-kernel-owner+w=401wt.eu-S1755005AbWL1Vml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbWL1Vml (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbWL1Vml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:42:41 -0500
Received: from [139.30.44.16] ([139.30.44.16]:5507 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755005AbWL1Vmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:42:40 -0500
Date: Thu, 28 Dec 2006 22:42:29 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228213438.GD20596@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0612282239190.20531@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
 <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
 <20061228213438.GD20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Russell King wrote:

> To cover these, you need to build at least rpc_defconfig, lubbock_defconfig,
> netwinder_defconfig, badge4_defconfig, cerf_defconfig, ...etc...

OK, I'll try to do that.
Do I need to build all the configs in arch/arm/configs?

> The whole "all*config" idea on ARM is utterly useless - you can _not_
> get build coverage that way.

Or shall I exclude the arm specific drivers for now?

Tim
