Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVG3QNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVG3QNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVG3QNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:13:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45581 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262998AbVG3QNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:13:12 -0400
Date: Sat, 30 Jul 2005 17:13:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -rc4: arm broken?
Message-ID: <20050730171308.A26592@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050730130406.GA4285@elf.ucw.cz>; from pavel@ucw.cz on Sat, Jul 30, 2005 at 03:04:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 03:04:06PM +0200, Pavel Machek wrote:
> I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> oops-like display, and it seems to be __call_usermodehelper /
> do_execve / load_script related. Anyone seen it before?

I've run -rc4 on an ARM SMP system (with extra patches to sort out
the previously reported problem) and it seemed happy.  I'll be
testing a SA1100 kernel later today (mainly for the UCB stuff.)
Stay tuned.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
