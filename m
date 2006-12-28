Return-Path: <linux-kernel-owner+w=401wt.eu-S965014AbWL1WXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWL1WXX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWL1WXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:23:23 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2802 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965014AbWL1WXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:23:22 -0500
Date: Thu, 28 Dec 2006 22:23:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-ID: <20061228222314.GG20596@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de> <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de> <20061228210803.GR17561@ftp.linux.org.uk> <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de> <20061228213438.GD20596@flint.arm.linux.org.uk> <20061228133246.ad820c6a.randy.dunlap@oracle.com> <20061228214830.GF20596@flint.arm.linux.org.uk> <Pine.LNX.4.63.0612282251560.6944@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612282251560.6944@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 10:53:44PM +0100, Tim Schmielau wrote:
> On Thu, 28 Dec 2006, Russell King wrote:
> > Given that it takes about 8 to 12 hours to do a build cycle, that's
> 
> My build cycle takes about 2 hours for 4 configs, on a decent AMD64 
> system (running completely in tmpfs). Am I doing something wrong or are 
> you talking about native builds?

I'm talking about cross-builds...  I don't know the spec of the machine,
only that it's x86 based (I don't run it.)

The last report at the beginning of this month said: 11 1/2 hours per
git snapshot, which is apparantly for building a total of about 115
kernels covering all ARM defconfigs, MIPS, PPC, and i386.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
