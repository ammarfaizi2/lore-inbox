Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVIHV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVIHV0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVIHV0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:26:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11658
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965003AbVIHV0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:26:40 -0400
Date: Thu, 08 Sep 2005 14:26:29 -0700 (PDT)
Message-Id: <20050908.142629.12531474.davem@davemloft.net>
To: torvalds@osdl.org
Cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
References: <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
	<20050908.134259.51218842.davem@davemloft.net>
	<Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 8 Sep 2005 14:22:37 -0700 (PDT)

> On Thu, 8 Sep 2005, David S. Miller wrote:
> > 
> > Ok, I'll revert the patch and fix the sunsab.c driver as
> > Russell indicated.  So much for type checking...
> 
> Actually, I think there's a simpler fix. Instead of reverting, how about 
> something like this?
> 
> (You might even remove the #ifdef inside the function by then, since "ch" 
> being a constant zero will make 90% of it go away anyway).
> 
> rmk? Davem?

I'm fine with this.
