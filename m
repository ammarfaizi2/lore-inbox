Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVLVNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVLVNTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVLVNTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:19:40 -0500
Received: from math.ut.ee ([193.40.36.2]:55244 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965147AbVLVNTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:19:39 -0500
Date: Thu, 22 Dec 2005 15:19:33 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <20051222130744.GA31339@flint.arm.linux.org.uk>
Message-ID: <Pine.SOC.4.61.0512221516580.18164@math.ut.ee>
References: <1134573803.25663.35.camel@localhost.localdomain>
 <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I notice you're using gcc 4.0.3.  Have you tried other compiler
> versions?

Will try 3.3.

> Are you building the kernel with any additional compiler flags?

No.

> Are there any other patches applied to the 8250.c file apart from my
> debugging patch?  What's the diff between a vanilla Linus kernel and
> the one you built?

Clean uptodate -git tree + your patch + BUG_ON

Also have seen this on many earlier kernels that were 100% vanilla.

Both machines having the trouble have kernels that are compiled on this 
specific host and with this specific controller.

-- 
Meelis Roos (mroos@linux.ee)
