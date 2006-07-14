Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWGNUTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWGNUTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWGNUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:19:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62443
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422751AbWGNUTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:19:52 -0400
Date: Fri, 14 Jul 2006 13:19:57 -0700 (PDT)
Message-Id: <20060714.131957.57444250.davem@davemloft.net>
To: dwmw2@infradead.org
Cc: arjan@infradead.org, maillist@jg555.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152908202.3191.98.camel@pmac.infradead.org>
References: <44B7F062.8040102@jg555.com>
	<1152905987.3159.46.camel@laptopd505.fenrus.org>
	<1152908202.3191.98.camel@pmac.infradead.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 14 Jul 2006 21:16:42 +0100

> More to the point, now we're doing this from upstream we can be
> _consistent_ about telling them to sod off and fix their broken crap.
> 
> We no longer have to deal with cries of 'but it works on $SOMEDISTRO'
> when another distro tries to impose some sanity rather than just
> pandering to it.
> 
> Kernel headers are _not_ a library of random crap for userspace to use.

I totally agree.  When I saw that some dists make asm/page.h define
PAGE_SIZE to "getpagesize()" for userspace, I nearly crapped myself.

That is insane, and encourages the problem to persist instead of
encouraging the right fix.
