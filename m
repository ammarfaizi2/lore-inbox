Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVCELji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVCELji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVCELjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 06:39:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10513 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263051AbVCELhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 06:37:38 -0500
Date: Sat, 5 Mar 2005 11:37:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
Message-ID: <20050305113730.B26541@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
	Richard Purdie <rpurdie@rpsys.net>
References: <422701A0.8030408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422701A0.8030408@drzeus.cx>; from drzeus-list@drzeus.cx on Thu, Mar 03, 2005 at 01:22:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:22:56PM +0100, Pierre Ossman wrote:
> Here are the patches for Secure Digital support that I've been sitting 
> on for a while. I tried to get some feedback on inclusion of this 
> previously but since I didn't get any I'll just submit the thing.
> It was originally diffed against 2.6.10 but it applies to 2.6.11 just 
> fine (only minor fuzz).

Can we please come to a consensus about GEN_FL_REMOVABLE.  After
talking to other kernel developers, particularly in the block
interface area, I am convinced that it is fundamentally incorrect
to set this flag for MMC/SD devices.

Unfortunately, it appears that you're not convinced.  This needs
resolving since it is an interface issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
