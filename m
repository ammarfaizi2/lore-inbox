Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVABIoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVABIoP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 03:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVABIoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 03:44:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261241AbVABIoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 03:44:13 -0500
Date: Sun, 2 Jan 2005 08:44:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix MMC warnings
Message-ID: <20050102084409.A1925@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D73B43.3080109@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41D73B43.3080109@drzeus.cx>; from drzeus-list@drzeus.cx on Sun, Jan 02, 2005 at 01:07:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 01:07:31AM +0100, Pierre Ossman wrote:
> Here's a patch that fixes the compiler warnings in mmc.c.

I'd rather the compiler was fixed so that it does proper analysis of
the code, rather than blatently issuing warnings for code which is
unreachable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
