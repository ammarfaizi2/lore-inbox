Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVIKSYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVIKSYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVIKSYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:24:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15052
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965017AbVIKSYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:24:23 -0400
Date: Sun, 11 Sep 2005 11:24:08 -0700 (PDT)
Message-Id: <20050911.112408.19208990.davem@davemloft.net>
To: torvalds@osdl.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sungem driver patch testing..
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
	<20050911120332.GA7627@infradead.org>
	<Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 11 Sep 2005 10:07:14 -0700 (PDT)

> On Sun, 11 Sep 2005, Christoph Hellwig wrote:
> > 
> > While we're at it the cpp conditioal looks bogus.  We definitly needs this
> > when plugging a SUN card into a mac.  I'd suggest compiling this
> > unconditionally and fall back to it when whatever firmware method to get
> > the mac address fails.
> 
> Here's a patch (on top of the previous PCI ROM mapping fix) that does
> that.

The Apple firmware actually is the same kind of FORTH firmware the
SUN cards use too.  Apple bought the FORTH firmware technology from
Sun so they could use it in their machines.

Whether it actually _works_ I do not know, but in theory it is very
possible that it does.

Just something to keep in mind. :-)

> Maybe the PCI rom mapping code should report when it just makes up a
> random address?

I agree that it should.
