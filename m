Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVJ3KQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJ3KQw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJ3KQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:16:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36365 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751218AbVJ3KQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:16:51 -0500
Date: Sun, 30 Oct 2005 10:16:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use command class to determine read-only status.
Message-ID: <20051030101646.GA26501@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20051028073605.4108.41408.stgit@poseidon.drzeus.cx> <20051028201455.GI4464@flint.arm.linux.org.uk> <4363FA3E.3000701@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4363FA3E.3000701@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:39:58AM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >On Fri, Oct 28, 2005 at 09:36:05AM +0200, Pierre Ossman wrote:
> >>If a card doesn't support the "write block" command class then
> >>any attempts to open the device should reflect this by denying
> >>write access.
> >
> >I'd rather we kept printk messages as one printk if at all possible.
> >How about encapsulating both of these conditions into an inline
> >function:
> >
> 
> Ok with me. New patch included.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
