Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWBSIPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWBSIPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 03:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWBSIPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 03:15:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25871 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750945AbWBSIPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 03:15:30 -0500
Date: Sun, 19 Feb 2006 08:15:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: don't bother users with unimportant messages.
Message-ID: <20060219081523.GA9668@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060219010910.GA18841@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219010910.GA18841@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 08:09:10PM -0500, Dave Jones wrote:
> When users see these printed to the console, they think
> something is wrong.  As it's just informational and something
> that only developers care about, lower the printk level.

If you're getting complaints about this, wouldn't it be better to
forward them here so that they can be fixed up?

The thing about this particular message is that if you see it, the
driver will _not_ work properly, so it's actually more than a
"debugging" message.  It's telling you why driver FOO doesn't work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
