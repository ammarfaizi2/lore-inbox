Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752627AbWAHOZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbWAHOZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbWAHOZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:25:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62991 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752630AbWAHOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:25:49 -0500
Date: Sun, 8 Jan 2006 14:25:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Lindent wbsd driver
Message-ID: <20060108142535.GC10927@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:17:48AM +0100, Pierre Ossman wrote:
> @@ -1079,9 +1030,9 @@ static int wbsd_get_ro(struct mmc_host* 
>  }
>  
>  static struct mmc_host_ops wbsd_ops = {
> -	.request	= wbsd_request,
> -	.set_ios	= wbsd_set_ios,
> -	.get_ro		= wbsd_get_ro,
> +	.request = wbsd_request,
> +	.set_ios = wbsd_set_ios,
> +	.get_ro = wbsd_get_ro,

In addition to Alexey's comments, I think this was better before being
"reindented".  If you agree, could you produce a new patch please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
