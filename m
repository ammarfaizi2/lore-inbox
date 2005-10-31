Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVJaVDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVJaVDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVJaVDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:03:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbVJaVDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:03:34 -0500
Date: Mon, 31 Oct 2005 13:03:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, stable@kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Dimitri Puzin <tristan-777@ddkom-online.de>,
       nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [stable] [2.6 patch] fix XFS_QUOTA for modular XFS
Message-ID: <20051031210305.GR5856@shell0.pdx.osdl.net>
References: <20051028203325.GD4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028203325.GD4180@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> This patch by Dimitri Puzin submitted through kernel Bugzilla #5514 
> fixes the following issue:
> 
> Cannot build XFS filesystem support as module with quota support. It 
> works only when the XFS filesystem support is compiled into the kernel. 
> Menuconfig prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.

Thanks, will queue for -stable, but this hasn't made it upstream yet.

thanks,
-chris
