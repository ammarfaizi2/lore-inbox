Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVJ2Ivh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVJ2Ivh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVJ2Ivh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:51:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750828AbVJ2Ivh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:51:37 -0400
Date: Sat, 29 Oct 2005 09:51:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: struct semaphore.sleepers initialization
Message-ID: <20051029085128.GA32513@flint.arm.linux.org.uk>
Mail-Followup-To: Arthur Othieno <a.othieno@bluewin.ch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051029032635.GA1870@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029032635.GA1870@krypton>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 11:26:35PM -0400, Arthur Othieno wrote:
> No one may sleep on us until we've been down()'d. So on allocation,
> initialize `sleepers' to 0, just like everyone else (including arm26).

And the point of this patch is what exactly?  Unnamed initialisers
will be initialised to zero, so you haven't actually changed anything.

NACKed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
