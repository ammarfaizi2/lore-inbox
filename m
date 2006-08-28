Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWH1IT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWH1IT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWH1IT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:19:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31117
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750969AbWH1IT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:19:27 -0400
Date: Mon, 28 Aug 2006 01:19:29 -0700 (PDT)
Message-Id: <20060828.011929.66059812.davem@davemloft.net>
To: ak@suse.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, jdike@addtoit.com,
       B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608281015.38389.ak@suse.de>
References: <200608281003.02757.ak@suse.de>
	<20060828.010948.131918560.davem@davemloft.net>
	<200608281015.38389.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Mon, 28 Aug 2006 10:15:38 +0200

> I see it as the reference implementation of the kernel system call
> ABI

I see it as duplication because the person who writes the
kernel is the one who ends up writing the libc syscall
bits or explains to the libc person for that arch how
things work.  And once one libc implmenetation of this
exists, it can be used as a reference for other libc
variants.

Finally, once it's done, it's done, and that's it.
