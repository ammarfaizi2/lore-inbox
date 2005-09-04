Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVIDKd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVIDKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVIDKd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 06:33:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35081 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750731AbVIDKd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 06:33:58 -0400
Date: Sun, 4 Sep 2005 11:33:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix compilation in locomo.c
Message-ID: <20050904113351.B30509@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050726063043.GI8684@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050726063043.GI8684@elf.ucw.cz>; from pavel@suse.cz on Tue, Jul 26, 2005 at 08:30:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 08:30:43AM +0200, Pavel Machek wrote:
> Do not access children in struct device directly, use
> device_for_each_child helper instead. It fixes compilation.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Given up waiting for John/Richard to okay this, applied anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
