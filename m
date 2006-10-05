Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWJEITj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWJEITj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJEITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:19:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWJEITg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:19:36 -0400
Date: Thu, 5 Oct 2006 01:19:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Message-Id: <20061005011909.3e1a9fec.akpm@osdl.org>
In-Reply-To: <20061005011608.b69e3461.akpm@osdl.org>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	<20061005011608.b69e3461.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 01:16:08 -0700
Andrew Morton <akpm@osdl.org> wrote:

> It's been stuck for a minute or more at the 12.980000 time, seems to have
> hung.

It just did something:

[   12.112000] kjournald starting.  Commit interval 5 seconds
[   12.160000] EXT3-fs: recovery complete.
[   12.164000] EXT3-fs: mounted filesystem with ordered data mode.
[   12.980000] audit(1160010604.980:2): enforcing=1 old_enforcing=0 auid=4294967295
[   18.808000] security:  3 users, 6 roles, 1417 types, 151 bools, 1 sens, 256 cats
[   18.812000] security:  57 classes, 41080 rules
[   18.816000] SELinux:  Completing initialization.
[   18.816000] SELinux:  Setting up existing superblocks.
[   18.824000] SELinux: initialized (dev sda6, type ext3), uses xattr
[   18.860000] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs


Those "six seconds" took at least three minutes.  With luck I'll have a
login prompt tomorrow morning.
