Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUCILS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUCILS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:18:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:5841 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261874AbUCILSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:18:25 -0500
Subject: Re: Benh Kernel 2.4.25 and 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040309092406.6513fd7c@zrr.local>
References: <20040309092406.6513fd7c@zrr.local>
Content-Type: text/plain
Message-Id: <1078830927.9745.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 22:15:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 19:24, Zeno R.R. Davatz wrote:
> Hi
> 
> I build in a new 80 GB HDD in my G3 Pismo. Then I build the system from Gentoo-LiveCD and installed the kernel from source. Problems:
> 
> 2.4.25-benh
> ***********
> I rsync'd with rsync.penguinppc.org::linux-2.4-benh and build the kernel.
> 
> When I boot my G3 Pismo I get:
> OOps: kernel access of bad area, sig: 11
> NIP: C0012C6 XER: 00000000 LR: C0307120  SP: C02B0CE0 REGS: c02b0c30 TRAP: 0300 Not tainted
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 40000000
> TASK= c02aed30[0] etc
> 
> this repeats twice and then reboots the maschine. 

A lookup of those values (NIP and LR at least) in System.map would be
useful.

> 2.6.3-benh (gentoo: ppc-development-sources)
> **********
> This one boots fine till /proc .....   [ok]
> 
> than the maschine just hangs. I got udev installed.

Can you test with current linus bk snapshots ? Let me know.

Ben.


