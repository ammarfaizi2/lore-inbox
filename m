Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263782AbUECWrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUECWrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUECWrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:47:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:784 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263782AbUECWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:47:16 -0400
Date: Mon, 3 May 2004 23:47:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 1/4 MMC layer
Message-ID: <20040503234710.B25413@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040429134824.C16407@flint.arm.linux.org.uk> <20040502155226.B17905@flint.arm.linux.org.uk> <20040503134744.GD1188@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040503134744.GD1188@openzaurus.ucw.cz>; from pavel@suse.cz on Mon, May 03, 2004 at 03:47:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 03:47:45PM +0200, Pavel Machek wrote:
> > As there haven't been any comments, can I assume that either people
> > don't care, or people are happy for this to appear in Linus' tree?
> 
> Happy. i386 nx5k notebook contains mmc slot, and I assume
> this will help me with a driver.

That depends on the kind of hardware interface you have - whether it
gives you low level access to the MMC command/data streams, or whether
it looks like a USB device / CF disk / whatever else.  (I've heard
rumours that such games are played on laptops, but I've no idea how
true this is.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
