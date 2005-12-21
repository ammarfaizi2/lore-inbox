Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVLULEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVLULEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVLULEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:04:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61457 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932361AbVLULE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:04:29 -0500
Date: Wed, 21 Dec 2005 11:04:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.j
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221110421.GA26630@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.j
References: <20051221012750.GD5359@stusta.de> <20051221024133.93b75576.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221024133.93b75576.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 02:41:33AM -0800, Andrew Morton wrote:
> Yes, it's basically always wrong to include asm/foo.h when linux/foo.h
> exists. 

There's always an exception to every rule.  linux/irq.h is that
exception for the above rule.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
