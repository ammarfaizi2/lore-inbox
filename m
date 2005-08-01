Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVHAF1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVHAF1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVHAF1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:27:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6598
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262318AbVHAFZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:25:14 -0400
Date: Sun, 31 Jul 2005 22:25:04 -0700 (PDT)
Message-Id: <20050731.222504.77057517.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: git-net-fixup.patch added to -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050731222125.37ab12e8.akpm@osdl.org>
References: <200508010504.j7154m5B022440@shell0.pdx.osdl.net>
	<20050731.221246.68159198.davem@davemloft.net>
	<20050731222125.37ab12e8.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 31 Jul 2005 22:21:25 -0700

> Actually, that patch is just a fixup for a patch reject from the net-2.6.14
> diff.  I do that sometimes when I get sick of fixing up the same reject
> each time I pull the various trees.
> 
> (I'm not sure _why_ I'm getting a reject applying that diff.  Nothing else
> touches that file.  git is not quite yet generating the linus->davem diff
> which I want..)

There is a tiny bit of conflicts between linux-2.6 and net-2.6.14,
because of some bug fixes that went into Linus's tree over the
past week.

I'll try to rebuild the net-2.6.14 tree if I get a chance before
heading off to the UK tomorrow.  That should help things out for
you.
