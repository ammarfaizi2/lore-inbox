Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVHGNTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVHGNTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 09:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVHGNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 09:19:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751504AbVHGNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 09:19:04 -0400
Date: Sun, 7 Aug 2005 14:18:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix warning in sa1100fb.c
Message-ID: <20050807141858.A22977@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730143551.GI1830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050730143551.GI1830@elf.ucw.cz>; from pavel@ucw.cz on Sat, Jul 30, 2005 at 04:35:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 04:35:51PM +0200, Pavel Machek wrote:
> Fix compile-time warning in sa1100fb.c

I think it makes sense to change this to an inline function.  Thanks
for pointing this out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
