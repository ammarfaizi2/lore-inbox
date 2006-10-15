Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWJOMZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWJOMZG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 08:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJOMZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 08:25:06 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:12307 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964797AbWJOMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 08:25:05 -0400
Date: Sun, 15 Oct 2006 13:24:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-ID: <20061015122453.GA12549@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014111458.GI30596@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 01:14:58PM +0200, Adrian Bunk wrote:
> As usual, we are swamped with bug reports for regressions after -rc1.
> 
> For an easier reading (and hoping linux-kernel might not eat the emails), 
> I've splitted the list of known regressions in three emails:
>   [1/3] known unfixed regressions
>   [2/3] knwon regressions with workarounds
>   [3/3] known regressions with patches

There's a raft of ARM regressions as well (see
http://armlinux.simtec.co.uk/kautobuild/2.6.19-rc2/index.html), mostly
related to the IRQ changes, as well as this error:

sysctl_net.c:(.text+0x64a8c): undefined reference to `highest_possible_node_id'

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
