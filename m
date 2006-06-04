Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750757AbWFDQlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWFDQlV (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWFDQlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:41:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750757AbWFDQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:41:20 -0400
Date: Sun, 4 Jun 2006 17:41:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Prevent au1xmmc.c breakage on non-Au1200 Alchemy
Message-ID: <20060604164112.GA4484@flint.arm.linux.org.uk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060603231827.GA2788@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603231827.GA2788@linux-mips.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 12:18:28AM +0100, Ralf Baechle wrote:
> The driver is selectable on other than Au1200 Alchemy systems but won't
> build nor work - there is no MMC hw.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
