Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbUKPFLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbUKPFLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUKPFIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:08:35 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:15527 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261811AbUKPFF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:05:28 -0500
Date: Tue, 16 Nov 2004 00:03:16 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] misc ISAPNP cleanups
Message-ID: <20041116050316.GC29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, Adrian Bunk <bunk@stusta.de>,
	perex@suse.cz, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
References: <20041113030234.GX2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113030234.GX2249@stusta.de>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 04:02:34AM +0100, Adrian Bunk wrote:
> The patch below removes some completely unused code and makes some 
> needlessly global code static in drivers/pnp/isapnp/core.c .
> 
> Please review whether this patch is correct or whether it conflicts with 
> pending ISAPNP updates/usages.
> 
> 
> diffstat output:
>  drivers/pnp/isapnp/core.c |   47 ++++++++------------------------------
>  include/linux/isapnp.h    |   20 ----------------
>  2 files changed, 11 insertions(+), 56 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

I have to check that this doesn't break any obscure isapnp drivers.  Otherwise
it looks good.  Some of them, like "isapnp_alloc", look obvious.

Thanks,
Adam
