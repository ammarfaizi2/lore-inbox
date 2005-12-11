Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVLKTVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVLKTVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLKTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:21:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25101 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750810AbVLKTVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:21:23 -0500
Date: Sun, 11 Dec 2005 19:21:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, paulus@samba.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linux-sh@m17n.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051211192109.GA22537@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, linux-sh@m17n.org
References: <20051211185212.GQ23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211185212.GQ23349@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 07:52:12PM +0100, Adrian Bunk wrote:
> defconfig's shouldn't set CONFIG_BROKEN=y.

NACK.  This changes other configuration options in addition, for example
in collie_defconfig:

-CONFIG_MTD_OBSOLETE_CHIPS=y
-# CONFIG_MTD_AMDSTD is not set
-CONFIG_MTD_SHARP=y
-# CONFIG_MTD_JEDEC is not set

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
