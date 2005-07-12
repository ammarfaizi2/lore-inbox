Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVGLHXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVGLHXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGLHWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:22:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42252 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261227AbVGLHVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:21:40 -0400
Date: Tue, 12 Jul 2005 08:21:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: arm: how to operate leds on zaurus?
Message-ID: <20050712082134.C25543@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>,
	Hamera Erik <HAMERAE@cs.felk.cvut.cz>
References: <20050711193454.GA2210@elf.ucw.cz> <20050711204534.C1540@flint.arm.linux.org.uk> <20050711195059.GA2219@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050711195059.GA2219@elf.ucw.cz>; from pavel@ucw.cz on Mon, Jul 11, 2005 at 09:50:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 09:50:59PM +0200, Pavel Machek wrote:
> I'm afraid I do not have serial cable :-(. I'll try to get one [erik,
> do you have one you don't need?], but zaurus has "little" nonstandard
> connector.
> 
> Would code above work if executed later?

If done after the IO mappings are setup.  That will be after
paging_init() has been called.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
