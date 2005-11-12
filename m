Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVKLWKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVKLWKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVKLWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:10:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51730 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964841AbVKLWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:10:36 -0500
Date: Sat, 12 Nov 2005 22:10:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Florin Malita <fmalita@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sa1100 serial: sa1100_start_tx spinlock recursion
Message-ID: <20051112221031.GM28987@flint.arm.linux.org.uk>
Mail-Followup-To: Florin Malita <fmalita@gmail.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051110220937.4e26592e.fmalita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110220937.4e26592e.fmalita@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 10:09:37PM -0500, Florin Malita wrote:
> The serial core aquires the port spinlock before calling
> port->ops->start_tx(), so sa1100_start_tx() shouldn't try to lock it
> again.

Applied, thanks.

PS, please do not copy linux-kernel and linux-arm-kernel.  The latter
is set for member only posting and it's considered rude to cross post.
Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
