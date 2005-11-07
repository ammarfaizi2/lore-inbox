Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVKGVh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVKGVh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKGVh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:37:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50191 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965131AbVKGVh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:37:28 -0500
Date: Mon, 7 Nov 2005 21:37:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/pcmcia/pcmcia_ioctl.c
Message-ID: <20051107213722.GA11233@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
References: <20051107200351.GL3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107200351.GL3847@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:03:51PM +0100, Adrian Bunk wrote:
> This patch contains the scheduled removal of 
> drivers/pcmcia/pcmcia_ioctl.c plus the fallout of additional cleanups 
> after this removal.

Please don't prempt maitainers removing code which they've listed in
feature-removal.txt.  By doing so, you may discourage maintainers from
listing stuff in there.

Instead, it may be worth sending a short reminder instead?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
