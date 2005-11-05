Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVKEKhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVKEKhH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVKEKhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:37:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21257 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751352AbVKEKhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:37:05 -0500
Date: Sat, 5 Nov 2005 10:36:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use controller id instead of driver name for printks
Message-ID: <20051105103657.GC28438@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20051101120731.8145.20792.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101120731.8145.20792.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 01:07:32PM +0100, Pierre Ossman wrote:
> The printks that aren't for debugging should use the name of the controller,
> not the driver name. Multiple MMC controllers aren't that common today, but
> this is the right way to do things.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
