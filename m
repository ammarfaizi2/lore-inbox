Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUAXApj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUAXApj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:45:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266824AbUAXApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:45:38 -0500
Date: Sat, 24 Jan 2004 00:45:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arne Ahrend <aahrend@web.de>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-ID: <20040124004530.B25466@flint.arm.linux.org.uk>
Mail-Followup-To: Arne Ahrend <aahrend@web.de>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20040122210501.40800ea7.aahrend@web.de> <20040122213757.H23535@flint.arm.linux.org.uk> <20040123232025.4a128ead.aahrend@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040123232025.4a128ead.aahrend@web.de>; from aahrend@web.de on Fri, Jan 23, 2004 at 11:20:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:20:25PM +0100, Arne Ahrend wrote:
> > It works for me - with pcnet_cs.  Do you have ipv6 configured into the
> > kernel?
> 
> No.

Argh, it seems that several patches which were in the netdrv experimental
tree never got merged.

Jeff - what's the situation with the net driver experimental tree?
Could the DEV_STALE_CONFIG patches from around December time be
merged please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
