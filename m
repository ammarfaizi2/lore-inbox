Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbTIBLKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbTIBLKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:10:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7621 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261211AbTIBLJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:09:56 -0400
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
From: Martin Willemoes Hansen <mwh@sysrq.dk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030902113610.D29984@flint.arm.linux.org.uk>
References: <1062498150.356.9.camel@spiril.sysrq.dk>
	 <20030902113610.D29984@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1062500366.642.11.camel@hugoboss.sysrq.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 12:59:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 12:36, Russell King wrote:
> On Tue, Sep 02, 2003 at 12:22:30PM +0200, Martin Willemoes Hansen wrote:
> > Hi! Im getting an error when using my Airo PCMCIA WiFi card with the
> > 2.4.20, 2.4.21, 2.4.22 kernel. 
> > It works when im using 2.4.19 and lower.
> > 
> > The error message:
> > cardmgr[19]: starting, version is 3.2.4
> > cs: memory probe 0x0c0000-0x0ffff: excluding 0xc0000-0xcbfff
> 
> This isn't an error message as such.  It's the result of checking whether
> the memory in the specified range is actually available.
> 
> Can you describe the problem you're experiencing in any more detail
> please?

Sure, when I boot my laptop with any of the above mentioned kernels I
get the above message and the laptop freezes and stops whatever its
doing.

I will have to reset the machine and boot without having the card
inserted. When I insert the card after successfull boot the laptop
freezes.

If I can provided more details please ask me.

-- 
Martin Willemoes Hansen

--------------------------------------------------------
E-Mail	mwh@sysrq.dk	Website	mwh.sysrq.dk
IRC     MWH, freenode.net
--------------------------------------------------------               


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2003-09-02 at 12:36, Russell King wrote:
> On Tue, Sep 02, 2003 at 12:22:30PM +0200, Martin Willemoes Hansen wrote:
> > Hi! Im getting an error when using my Airo PCMCIA WiFi card with the
> > 2.4.20, 2.4.21, 2.4.22 kernel. 
> > It works when im using 2.4.19 and lower.
> > 
> > The error message:
> > cardmgr[19]: starting, version is 3.2.4
> > cs: memory probe 0x0c0000-0x0ffff: excluding 0xc0000-0xcbfff
> 
> This isn't an error message as such.  It's the result of checking whether
> the memory in the specified range is actually available.
> 
> Can you describe the problem you're experiencing in any more detail
> please?

Sure, when I boot my laptop with any of the above mentioned kernels I
get the above message and the laptop freezes and stops whatever its
doing.

I will have to reset the machine and boot without having the card
inserted. When I insert the card after successfull boot the laptop
freezes.

If I can provided more details please ask me.

-- 
Martin Willemoes Hansen

--------------------------------------------------------
E-Mail	mwh@sysrq.dk	Website	mwh.sysrq.dk
IRC     MWH, freenode.net
--------------------------------------------------------               


