Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWICHdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWICHdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWICHdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 03:33:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30735 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752129AbWICHdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 03:33:32 -0400
Date: Fri, 1 Sep 2006 21:17:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060901211754.GA4884@ucw.cz>
References: <20060830062338.GA10285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830062338.GA10285@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And the name is a bit ackward, anyone have a better suggestion?

drivers/uio (for userspace io driver)?

And yes, I think this one _should_ taint the kernel. When userspace
starts playing with interrupts, chances of kernel crash are high.

Does it work properly with pci shared interrupts?
-- 
Thanks for all the (sleeping) penguins.

-- 
VGER BF report: H 0.000174266
