Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVCEMok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVCEMok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVCEMoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:44:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:530 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263051AbVCEMo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:44:26 -0500
Date: Sat, 5 Mar 2005 12:44:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
Message-ID: <20050305124420.A342@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
	Richard Purdie <rpurdie@rpsys.net>
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4229A4B4.1000208@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Mar 05, 2005 at 01:23:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 01:23:16PM +0100, Pierre Ossman wrote:
> I can make a new patch or you can just undo that line once you've 
> applied the current one.

I'd rather not just apply this patch - there's rather a lot there to
just apply on top of what's already merged.

Is there any chance you can split it up into a smaller set of changes
so it's more obvious what's going on at each stage please?

We'll also need to run this by Linus first, explaining why you believe
it's now ok to merge this.  (Added Linus...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
